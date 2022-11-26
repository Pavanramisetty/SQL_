/*Look through Lesson 16c Data Definition Language - Tables.sql and 
  run the code examples there, then practice creating tables with the excercises below:
*/
--Practice creating tables

/* 1) Create the depts table per the following specification. Be sure to name
      the constraints other than NOT NULL.
      ------------------------------------------
      |Column Name |Datatype  |Size|Constraint |
      |------------|----------|----|-----------|
      |DEPT_NO     | NUMBER   | 4  |Primary Key|
      |------------|----------|----|-----------|
      |DEPT_NAME   | VARCHAR2 | 15 | NOT NULL  |
      ------------------------------------------
      
      Confirm the table structure after you create it.
  */
      
 
 
/* 2) Create the emps table per the following specification. Be sure to name
      the constraints other than NOT NULL.
      --------------------------------------------
      |Column Name |Datatype   |Size|Constraint  |
      |------------|-----------|----|------------|
      |EMP_NO      | NUMBER    | 4  |Primary Key |
      |------------|-----------|----|------------|
      |EMP_FNAME   | VARCHAR2  | 15 | NOT NULL   |
      |------------|-----------|----|------------|
      |EMP_LNAME   | VARCHAR2  | 15 | NOT NULL   |
      --------------------------------------------
      |EMP_DEPT_NO | NUMBER    | 4  | Foreign Key|
      --------------------------------------------
      
      Confirm the table structure after you create it.  */
 
 
 
 
/* 3) The emps and depts tables need some tweaking. Increase the maximum 
      length of dept_name to 30 characters. Increase the emp_no to 6 digits
      maximum, and increase the first and last names to a maximum length of
      25 characters. You must drop the tables and recreate them in the correct 
      order. Verify the correct table structures after recreating them. */
     
     
     
     
            
/* 4) Run the following Insert statement to populate the depts table with data 
      from all the rows in the departments table. You will learn how to copy rows
      from another table using the Insert statement in Lesson 18a Data Manipulation 
      Language and TCL. */

      INSERT INTO depts
          SELECT department_id, department_name
            FROM departments;  
        
        
/* 5) Create a table na_locs based on the structure and data of the locations 
      table. Include only the rows that have a country_id of CA, US, or MX. Confirm
      the table structure and data after you create it. */
      
     

        
/* 6) Create an emp_archive table based on the structure of the employees table.
      The table must be empty. CREATE the table with a subquery that returns
      no rows.*/ 
      
      
      
/* 7) In a separate session, write a script that will drop and create the trainees 
      and treams tables in the correct order. Name all constraints except 
      NOT NULL.
      
      ----------
      |STREAMS |
      --------------------------------------------
      |Column Name |Datatype   |Size|Constraint  |
      |------------|-----------|----|------------|
      |STREAM_ID   | NUMBER    | 5  |Primary Key |
      |------------|-----------|----|------------|
      |STREAM_NAME | VARCHAR2  | 15 | NOT NULL   |
      |------------|-----------|----|------------|
      |STREAM_DESC | VARCHAR2  | 40 | NOT NULL   |
      --------------------------------------------
      
      
      -----------
      |TRAINEES |
      -------------------------------------------------------------------
      |Column Name        |Datatype    |Size|Default Value |Constraint  |
      |-------------------|------------|----|--------------|-------------
      |TRAINEE_ID         | NUMBER     | 7  |              | PRIMARY KEY|
      |-------------------|------------|----|--------------|------------|
      |TRAINEE_SSN        | CHAR       | 9  |              | UNIQUE     |
      |-------------------|------------|----|--------------|------------|
      |TRAINEE_FNAME      | VARCHAR2   | 15 |              | NOT NULL   |
      --------------------|------------|----|--------------|------------|
      |TRAINEE_LNAME      | VARCHAR2   | 15 |              | NOT NULL   |
      --------------------|------------|----|--------------|------------|
      |TRAINEE_START_DATE | DATE       |    | SYSDATE      | NOT NULL   |
      |-------------------|------------|----|--------------|------------|
      |TRAINEE_TUITION    | NUMBER     | 9,2|              | > than zero|
      --------------------|------------|----|--------------|------------|
      |TRAINEE_STREAM_ID  | NUMBER     | 5  |              | FOREIGN KEY|
      -------------------------------------------------------------------
*/      
      