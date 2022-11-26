/*   Data Definition Language - Tables
================================================================================
Lesson Objectives: After this lesson, you should:
================================================================================
- Be able to create parent and child tables in the correct order.
- Know how to create tables with column-level and table-level constraints
- Be able to create virtual columns
- Drop tables in the correct order
- Know the difference between DELETE table and TRUNCATE table
--------------------------------------------------------------------------------
CREATE PARENT AND CHILD TABLES
 -Just like people, the parent tables must be created first, and then the 
   child tables that reference the parents can be created.
--------------------------------------------------------------------------------
Example 1 - Parent and child tables with unnamed column level constraints:
--------------------------------------------------------------------------------
*/
  CREATE TABLE streams
  (
    stream_id   NUMBER(5)  PRIMARY KEY,
    stream_name VARCHAR2(25) NOT NULL ,
    stream_desc VARCHAR2(50) NOT NULL
  );
  
  CREATE TABLE trainees
  (
    trainee_id  NUMBER(6) PRIMARY KEY ,
    trainee_ssn CHAR(9)   UNIQUE      ,
    trainee_fname VARCHAR2(15)  NOT NULL,
    trainee_lname VARCHAR2(15)  NOT NULL,
    trainee_reg_date  DATE DEFAULT SYSDATE,
    trainee_pay  NUMBER(7,2) CHECK (trainee_pay >= 0),
    trainee_stream_id NUMBER(5) REFERENCES streams(stream_id)
  );
/*
--------------------------------------------------------------------------------
It is not recommended you create tables with unnamed constraints as above. 
The RDBMS will name each constraint SYS_C#######, where ####### represents 
a six or seven digit number. In order to make your error messages easier to 
troubleshoot, and to make your constraints easier to lookup 
in the Data Dictionary, you should name your constraints yourself. Use unique, 
meaningful names as in the examples below. 
--------------------------------------------------------------------------------
Example 2 - Parent and child tables with named column-level constraints:                                                   */
--------------------------------------------------------------------------------
  DROP TABLE trainees;
  DROP TABLE streams;
  
  CREATE TABLE streams
  (
    stream_id   NUMBER(5)  CONSTRAINT stream_id_pk PRIMARY KEY,
    stream_name VARCHAR2(25) NOT NULL ,
    stream_desc VARCHAR2(50) NOT NULL
  );
  
  CREATE TABLE trainees
  (
    trainee_id    NUMBER(6) CONSTRAINT trainee_id_pk PRIMARY KEY ,
    trainee_ssn   CHAR(9)   CONSTRAINT trainee_ssn_uk UNIQUE     ,
    trainee_fname VARCHAR2(15)  NOT NULL,
    trainee_lname VARCHAR2(15)  NOT NULL,
    trainee_reg_date  DATE DEFAULT SYSDATE,
    trainee_pay  NUMBER(7,2)CONSTRAINT trainee_amt_ck
                                  CHECK (trainee_pay >= 0),
    trainee_stream_id NUMBER(5) CONSTRAINT trainee_stream_id_fk
                                  REFERENCES streams(stream_id)
  );

/*
--------------------------------------------------------------------------------
Alternatively, constraints can be created at the table level, after the last 
column definition.
-------------------------------------------------------------------------------
Example 3 - Table with named table-level constraints:   */
--------------------------------------------------------------------------------
  
  CREATE TABLE vendors
  (
  vendor_id       NUMBER(5)             ,
  vendor_name     VARCHAR2(25)  NOT NULL,
  vendor_phone    VARCHAR2(20)  NOT NULL,
  vendor_email    VARCHAR2(35)  NOT NULL,
  vendor_rel_mgr  NUMBER(6)             ,
  CONSTRAINT vendor_id_pk PRIMARY KEY(vendor_id),
  CONSTRAINT vendor_phone_ck CHECK (vendor_phone LIKE '+_ ___ ___ ____'),
  CONSTRAINT vendor_email_ck CHECK (vendor_email LIKE '%@%.___'),
  CONSTRAINT vendor_rel_mgr_fk FOREIGN KEY (vendor_rel_mgr)
                                      REFERENCES employees(employee_id)
  );
/*
--------------------------------------------------------------------------------
 Miscellaneous CREATE table items:
--------------------------------------------------------------------------------
-Identity Column and Virtual Column 
  --In the example below, customer_id is an identity, or auto-increment column.
  --Starting in Oracle 12, a table can have one such column
  --Customer_due_date is a virtual column. 
  --A virtual column is a column whose values are calculated automatically using 
    values from other columns.
-Multi-column Constraint 
  --The last constraint below checks the values of more 
    than one column at a time. */
--------------------------------------------------------------------------------
  DROP TABLE clients;
  CREATE TABLE clients
(
  client_id         NUMBER(5) GENERATED AS IDENTITY CONSTRAINT client_id_pk PRIMARY KEY,
  client_name       VARCHAR2(25)  NOT NULL,
  client_balance    NUMBER(7,2)         ,
  client_discount   NUMBER(2,2)         ,
  client_order_date DATE  DEFAULT SYSDATE,
  client_due_date   AS (client_order_date + 90),
  CONSTRAINT client_discount_ck CHECK(client_balance * client_discount <= 1000)
);

--------------------------------------------------------------------------------
-- CREATE a table based on a pre-existing table: 
--------------------------------------------------------------------------------

  CREATE TABLE salespersons
    AS SELECT *
         FROM employees
         WHERE job_id LIKE 'SA\_%' ESCAPE '\' ;

-------------------------------------------------------------------------------        
-- CREATE an empty table based on a pre-existing table.
-------------------------------------------------------------------------------

  CREATE TABLE emps_history
    AS SELECT *
          FROM employees
          WHERE 1 = 2;
/*
--------------------------------------------------------------------------------
ALTER table
--------------------------------------------------------------------------------
-The ALTER statement can be used to change the structure of a table. 
-It can be used to:
 --Add a new column
 --Modify an existing column defininition
 --Define a default value for a column
 --Rename a column
 --Drop a column
 --Change a table to read-only status
Due to its extensive capabilities in altering a table's structure, ALTER is 
discussed in APPENDIX A - Alter Statement.

--------------------------------------------------------------------------------
  DROP TABLE
--------------------------------------------------------------------------------
  -The DROP statement moves a table to the RECYCLEBIN. The RECYCLEBIN is 
   discussed in more detail in APPENDIX A.
  -Always drop all the child tables first. Then drop the parent table(s). 
  -Notice the parent table streams cannot be dropped before 
  -the child table trainees. */
--------------------------------------------------------------------------------  
  DROP TABLE streams;     --This will fail. trainees would be an orphan table.
--Drop them in the correct order:
  DROP TABLE trainees;    --Drop child tables first.
  DROP TABLE streams;     --Then drop parent tables.
/*
--------------------------------------------------------------------------------
  To DROP a parent table even though there are foreign keys referencing it, use
  the CASCADE CONSTRAINTS clause to also drop all foreign key constraints 
  referencing the table:
--------------------------------------------------------------------------------
*/  
    DROP TABLE streams CASCADE CONSTRAINTS;   --All foreign key constraints are dropped
                                              
    DROP TABLE trainees;                      --Child table
/*    
--------------------------------------------------------------------------------
TRUNCATE Table
--------------------------------------------------------------------------------
  -Removes all rows from a table similar to the DELETE statement.
  -Is a Data Definition Language statement.
  -Does not require COMMIT to complete.
  -ROLLBACK will not undo this command!
  -Is more efficient than DELETE because a snapshot is not copied to an Undo Segment.
  -Cannot be undone!
--------------------------------------------------------------------------------
*/
  TRUNCATE TABLE salespersons;
  TRUNCATE TABLE emps_history;
  