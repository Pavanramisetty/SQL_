DROP TABLE consultants;
DROP table sal_grades;
DROP TABLE sales CASCADE CONSTRAINTS PURGE;
DROP TABLE customers CASCADE CONSTRAINTS PURGE;
/*********************************************************************
    Create the CONSULTANTS table to hold the consultant personnel 
    information for the company. */
           
CREATE TABLE consultants
   ( consultant_id NUMBER(6) CONSTRAINT cons_cons_id_pk PRIMARY KEY 
   , first_name VARCHAR2(20) not null
   , last_name VARCHAR2(25) not null
   , email VARCHAR2(25) NOT NULL CONSTRAINT cons_email_uk UNIQUE
   , phone_number VARCHAR2(20)
   , hire_date DATE NOT NULL
   , job_id VARCHAR2(10)NOT NULL CONSTRAINT cons_job_fk REFERENCES jobs (job_id)
   , salary NUMBER(8,2) CONSTRAINT cons_salary_min CHECK (salary > 0)
   , commission_pct NUMBER(2,2)
   , manager_id NUMBER(6) CONSTRAINT cons_manager_fk REFERENCES employees
   , department_id NUMBER(4)CONSTRAINT cons_dept_fk REFERENCES departments
   ) ;
   
   
-- ********************************************************************
-- Create the SAL_GRADES table to hold the grade for each salary range 
   
CREATE TABLE sal_grades
   ( grade_level CHAR(3) CONSTRAINT sgrade_grade_level_pk PRIMARY KEY
   , lowest_sal NUMBER(8,2) NOT NULL
   , highest_sal NUMBER(8,2) NOT NULL
   , CONSTRAINT sgrade_sal_ck CHECK (lowest_sal < highest_sal)
   ) ;

-- ********************************************************************
-- Create the CUSTOMERS table to hold information about the company's customers

CREATE TABLE customers
 (
 cust_id    NUMBER(6) GENERATED AS IDENTITY (START WITH 2 INCREMENT BY 2)
                CONSTRAINT cust_id_pk PRIMARY KEY,
 cust_email       VARCHAR2(30) NOT NULL CONSTRAINT cust_email_uk UNIQUE,
 cust_fname       VARCHAR2(20) NOT NULL,
 cust_lname       VARCHAR2(20) NOT NULL,
 cust_address     VARCHAR2(50) NOT NULL,
 cust_city        VARCHAR2(50) NOT NULL,
 cust_state_province CHAR(2),
 cust_postal_code VARCHAR2(20)        ,
 cust_country     VARCHAR2(20) NOT NULL,
 cust_phone       VARCHAR2(20) NOT NULL ,
 cust_credit_limit  NUMBER(11,2) DEFAULT 1000
               CONSTRAINT cust_credit_limit_ck  CHECK(cust_credit_limit > 0)
  );
 
-- ********************************************************************
-- Create the sales table to provide transactional data:
 
CREATE Table sales
(
 sales_id       	NUMBER(12) GENERATED AS IDENTITY 
						CONSTRAINT sales_id_pk PRIMARY KEY,
 sales_timestamp    TIMESTAMP NOT NULL,
 sales_amt    		NUMBER(8,2),
 sales_cust_id  	NUMBER(6) CONSTRAINT sales_cust_id_fk REFERENCES customers(cust_id),
 sales_rep_id   	NUMBER(6) CONSTRAINT sales_rep_id_fk REFERENCES employees(employee_id)
 );
 
 
 -- ********* insert data into the CONSULTANTS table

INSERT INTO consultants VALUES 
   ( 1
   , 'Ron'
   , 'Soltani'
   , 'RSOLTANI'
   , '515.321.1234'
   , TO_DATE('17-MAR-16', 'DD-MON-RR')
   , 'SA_REP'
   , 8300
   , .35
   , 149
   , 80
   );
  
  INSERT INTO consultants VALUES 
   ( 2
   , 'Eric'
   , 'Siglin'
   , 'ESIGLIN'
   , '515.321.2345'
   , TO_DATE('11-JUL-16', 'DD-MON-RR')
   , 'SA_REP'
   , 8300
   , .30
   , 149
   , 80
   ); 
   
   INSERT INTO consultants VALUES
   ( 3
   , 'Joe'
   , 'Roch'
   , 'JROCH'
   , '515.321.3456'
   , TO_DATE('10-AUG-16', 'DD-MON-RR')
   , 'SA_REP'
   , 8300
   , .30
   , 149
   , 80
   );
  
  INSERT INTO consultants VALUES 
   ( 4
   , 'Sean'
   , 'Kim'
   , 'SKIM'
   , '515.321.4567'
   , TO_DATE('11-AUG-16', 'DD-MON-RR')
   , 'SA_REP'
   , 8300
   , .30
   , 149
   , 80
   ); 
   
   INSERT INTO consultants VALUES 
   ( 5
   , 'Tim'
   , 'LeBlanc'
   , 'TLEBLANC'
   , '515.321.5678'
   , TO_DATE('07-AUG-17', 'DD-MON-RR')
   , 'SA_REP'
   , 8300
   , .25
   , 148
   , 80
   );
  
  INSERT INTO consultants VALUES 
   ( 6
   , 'Tammy'
   , 'McCullough'
   , 'TMCCULLOUGH'
   , '515.321.6789'
   , TO_DATE('07-AUG-17', 'DD-MON-RR')
   , 'SA_REP'
   , 8300
   , .25
   , 148
   , 80
   ); 
   
   INSERT INTO consultants VALUES
   ( 7
   , 'Nancy'
   , 'Greenberg'
   , 'NGREENBE'
   , '515.321.7890'
   , TO_DATE('07-AUG-17', 'DD-MON-RR')
   , 'SA_REP'
   , 8300
   , .25
   , 147
   , 80
   );
  
  INSERT INTO consultants VALUES 
   ( 8
   , 'Gerry'
   , 'Jurrens'
   , 'JGURRENS'
   , '515.321.8901'
   , TO_DATE('11-AUG-17', 'DD-MON-RR')
   , 'SA_REP'
   , 9000
   , .40
   , 146
   , 80
   ); 
   
   INSERT INTO consultants VALUES 
   ( 9
   , 'Steve'
   , 'Jones'
   , 'SJONES'
   , '515.321.9012'
   , TO_DATE('15-SEP-17', 'DD-MON-RR')
   , 'SA_REP'
   , 9000
   , .40
   , 146
   , 80
   );
  
  INSERT INTO consultants VALUES 
   ( 10
   , 'Wayne'
   , 'Abbott'
   , 'WABBOTT'
   , '515.321.0123'
   , TO_DATE('15-SEP-17', 'DD-MON-RR')
   , 'SA_REP'
   , 9000
   , .40
   , 146
   , 80
   ); 
   
  INSERT INTO consultants VALUES
   ( 11
   , 'Vance'
   , 'Jones'
   , 'VJONES'
   , '515.421.1234'
   , TO_DATE('04-APR-18', 'DD-MON-RR')
   , 'SA_REP'
   , 9500
   , .45
   , 145
   , 80
   );
  
  INSERT INTO consultants VALUES 
   ( 12
   , 'Bill'
   , 'Mayers'
   , 'BMAYERS'
   , '515.421.2345'
   , TO_DATE('02-MAY-18', 'DD-MON-RR')
   , 'SA_REP'
   , 8300
   , .25
   , 149
   , 80
   ); 
   
   INSERT INTO consultants VALUES 
   ( 13
   , 'Bob'
   , 'Witty'
   , 'BWITTY'
   , '515.421.3456'
   , TO_DATE('01-JUN-18', 'DD-MON-RR')
   , 'SA_REP'
   , 8300
   , .25
   , 148
   , 80
   );
  
  INSERT INTO consultants VALUES 
   ( 14
   , 'Michael'
   , 'Thum'
   , 'MTHUM'
   , '515.421.4567'
   , TO_DATE('07-AUG-17', 'DD-MON-RR')
   , 'SA_REP'
   , 8300
   , .25
   , 147
   , 80
   ); 
  
  INSERT INTO consultants VALUES 
   ( 15
   , 'James'
   , 'Little'
   , 'JLITTLE'
   , '515.421.5678'
   , TO_DATE('07-AUG-17', 'DD-MON-RR')
   , 'SA_REP'
   , 8500
   , .30
   , 146
   , 80
   );
  
  INSERT INTO consultants VALUES 
   ( 16
   , 'Angie'
   , 'Seydel'
   , 'ASEYDEL'
   , '515.421.6789'
   , TO_DATE('11-AUG-17', 'DD-MON-RR')
   , 'SA_REP'
   , 8500
   , .25
   , 146
   , 80
   );
  
  INSERT INTO consultants VALUES 
   ( 17
   , 'Heidi'
   , 'Taylor'
   , 'HTAYLOR'
   , '515.421.7890'
   , TO_DATE('06-FEB-17', 'DD-MON-RR')
   , 'SA_REP'
   , 8700
   , .35
   , 147
   , 80
   );
   
COMMIT;	-- Per Jonathan Young July 22, 2022

   
 -- ********* insert data into the SAL_GRADES table
       

INSERT INTO sal_grades
         VALUES ('A'
   , 1000
   , 2999);
   
INSERT INTO sal_grades
         VALUES ('B'
   , 3000
   , 5999);
   
INSERT INTO sal_grades
         VALUES ('C'
   , 6000
   , 9999);
   
INSERT INTO sal_grades
         VALUES ('D'
   , 10000
   , 14999);
   
INSERT INTO sal_grades
         VALUES ('E'
   , 15000
   , 24999);
   
INSERT INTO sal_grades
         VALUES ('F'
   , 25000
   , 40000);

COMMIT;	-- Per Jonathan Young July 22, 2022

-- Insert data into the CUSTOMERS table:

 INSERT INTO CUSTOMERS(cust_email, cust_fname, cust_lname, cust_address, cust_city,
    cust_state_province, cust_postal_code, cust_country, cust_phone, cust_credit_limit)
  VALUES('bjayne@shu.edu', 'Bill', 'Jayne', '52 Main St.', 'Madison', 'NJ', '07940',
          'US', '+1 973 555 1212', 2000.99);
 INSERT INTO CUSTOMERS(cust_email, cust_fname, cust_lname, cust_address, cust_city,
    cust_state_province, cust_postal_code, cust_country, cust_phone, cust_credit_limit)
  VALUES('aoconnell@aol.com', 'Audrey', 'O''Connell', '15 W. Park St.', 'Butte', 'MT', '57911',
          'US', '+1 406 555 1212', 2200); 
 INSERT INTO CUSTOMERS(cust_email, cust_fname, cust_lname, cust_address, cust_city,
     cust_postal_code, cust_country, cust_phone, cust_credit_limit)
  VALUES('efrey@vodafone.net', 'Evelyn', 'Frey', '17 Brooksby St.', 'London', 'N1 1HE',
          'GB', '+44 020 755 1212', 1800.50);
 INSERT INTO CUSTOMERS(cust_email, cust_fname, cust_lname, cust_address, cust_city,
    cust_state_province, cust_postal_code, cust_country, cust_phone, cust_credit_limit)
  VALUES('dtone@abc.com', 'Deborah', 'Tone', '234 Beverley St.', 'Winnipeg', 'MB', 'R3G 1T6',
          'CA', '+1 204 555 1212', 2000); 
 INSERT INTO CUSTOMERS(cust_email, cust_fname, cust_lname, cust_address, cust_city,
    cust_state_province, cust_postal_code, cust_country, cust_phone, cust_credit_limit)
  VALUES('fterziotti@alitalia.com', 'Fabio', 'Terziotti', '72 Via Belviglieri', 'Verona', 'VR', '37131',
          'IT', '+39 045 555 1212', 5000);
 INSERT INTO CUSTOMERS(cust_email, cust_fname, cust_lname, cust_address, cust_city,
    cust_postal_code, cust_country, cust_phone, cust_credit_limit)
  VALUES('eikeloa@bluebird.net', 'Emanuel', 'Ikeloa', '745 Agbe Rd.', 'Lagos', '100212',
          'NG', '+234 1 555 1212', 2300); 
 INSERT INTO CUSTOMERS(cust_email, cust_fname, cust_lname, cust_address, cust_city,
      cust_country, cust_phone, cust_credit_limit)
  VALUES('chenliu@bochk.com', 'Chen', 'Liu', '39 Dai Shing St.', 'Wan Chai',
          'HK', '+852 2555 1212', 2300);
 INSERT INTO CUSTOMERS(cust_email, cust_fname, cust_lname, cust_address, cust_city,
    cust_state_province, cust_postal_code, cust_country, cust_phone, cust_credit_limit)
  VALUES('alotero@caracol.co', 'Andres', 'Lotero', '405 Carrera 93', 'Bogota', 'DC', '110721',
          'CO', '+57 300 794 5529', 3600); 
 INSERT INTO CUSTOMERS(cust_email, cust_fname, cust_lname, cust_address, cust_city,
    cust_postal_code, cust_country, cust_phone, cust_credit_limit)
  VALUES('gong.li@uobgroup.com', 'Gong', 'Li', '42 Cambridge Rd.', 'Cambridge', '219687',
          'SG', '+65 973 555 1212', 3500);
 INSERT INTO CUSTOMERS(cust_email, cust_fname, cust_lname, cust_address, cust_city,
    cust_state_province, cust_postal_code, cust_country, cust_phone, cust_credit_limit)
  VALUES('sganesan@abanoffshore.com', 'Shivaji', 'Ganesan', '15 Adithanar Rd.', 'Chennai', 'TN', '600 018',
          'IN', '+91 406 555 1212', 2800); 


-------------------------------------------------------------------------------------------  		  
-- Insert data into the sales table:		  
              
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '936' hour, 483.92, 2, 176);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '865' hour, 123.45, 8, 150); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '71' hour, 9374.61, 12, 163);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '746' hour, 492.58, 10, 176);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '39' hour, 104.93, 18, 164); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '840' hour, 808.73, 16, 174);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '583' hour, 938.65, 14, 170);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '291' hour, 274.98, 16, 176);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '82' hour, 2483.76, 10, 152); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '394' hour, 364.92, NULL, 155); 
  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '485' hour, 33.13, 10, 168);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '36' hour, 789.34, 18, 156); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '19' hour, 4958.36, 12, 170);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '26' hour, 6028.38, 16, 153);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '623' hour, 9024.30, 8, 178); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '698' hour, 430.73, 10, 159);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '294' hour, 329.65, 14, 163);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '409' hour, 215.98, 4, 158);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '836' hour, 364.92, NULL, 161); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '51' hour, 293.76, 2, 174);  

  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '45' hour, 343.13, 16, 160);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '376' hour, 8279.16, 8, 162); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '194' hour, 5829.47, 12, 151);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '260' hour, 9375.27, 2, 154);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '23' hour, 914.30, 4, 168); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '98' hour, 573.82, 18, 166);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '148' hour, 827.51, NULL, 167); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '29' hour, 319.65, 10, 169);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '49' hour, 695.89, 16, 164);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '534' hour, 259.76, 10, 157); 
  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '295' hour, 463.31, 16, 152);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '626' hour, 7589.34, 2, 165); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '54' hour, 3052.42, 16, 151);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '391' hour, 381.53, NULL, 173);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '22' hour, 6828.38, 10, 154);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '271' hour, 739.51, 14, 171); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '918' hour, 590.73, 8, 177);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '38' hour, 639.27, 10, 175);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '41' hour, 965.98, 4, 152);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '729' hour, 6274.22, NULL, 179);
  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '92' hour, 769.52, 8, 172); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '72' hour, 5293.46, 16, 150);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '825' hour, 4385.97, 8, 175); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '92' hour, 2937.28, 10, 152);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '17' hour, 3948.88, 10, 159);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '647' hour, 992.45, 14, 160); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '175' hour, 917.38, 16, 157);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '28' hour, 723.85, 4, 159);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '73' hour, 826.42, 16, 156);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '412' hour, 259.34, 8, 172); 
  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '49' hour, 3781.39, 16, 174);  
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '39' hour, 4381.39, 16, 170); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '389' hour, 2367.82, 18, 170); 
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '47' hour, 4211.39, 2, 177);
  INSERT INTO sales(sales_timestamp, sales_amt, sales_cust_id, sales_rep_id)
    VALUES(LOCALTIMESTAMP - interval '463' hour, 611.31, 12, 158); 	
 
 -- *********************************************

COMMENT ON TABLE consultants
         IS 'consultants table. Contains 17 rows. References with departments, 
         jobs, employees tables.';

COMMENT ON COLUMN consultants.consultant_id
         IS 'Primary key of consultants table.';

COMMENT ON COLUMN consultants.first_name
         IS 'First name of the consultant. A not null column.';

COMMENT ON COLUMN consultants.last_name
         IS 'Last name of the consultant. A not null column.';

COMMENT ON COLUMN consultants.email
         IS 'Email id of the consultant';

COMMENT ON COLUMN consultants.phone_number
         IS 'Phone number of the consultant; includes country code and area code';

COMMENT ON COLUMN consultants.hire_date
         IS 'Date when the consultant started this job. A not null column.';

COMMENT ON COLUMN consultants.job_id
         IS 'Current job of the consultant; foreign key to job_id column of the 
         jobs table. A not null column.';

COMMENT ON COLUMN consultants.salary
         IS 'Monthly salary of the consultant. Must be greater 
         than zero (enforced by constraint cons_salary_min)';

COMMENT ON COLUMN consultants.commission_pct
         IS 'Commission percentage of the consultant; Only employees in sales 
         department elgible for commission percentage';

COMMENT ON COLUMN consultants.manager_id
         IS 'Manager id of the consultant; has same domain as manager_id in 
         departments table. Foreign key to employee_id column of employees table.';

COMMENT ON COLUMN consultants.department_id
         IS 'Department id where consultant works; foreign key to department_id 
         column of the departments table';


-- *********************************************

COMMENT ON TABLE sal_grades
         IS 'sal_grades table. Contains 6 rows. Does not reference any other
                tables.';

COMMENT ON COLUMN sal_grades.grade_level
         IS 'Primary key of sal_grades table.';

COMMENT ON COLUMN sal_grades.lowest_sal
         IS 'Lowest salary in the grade range. A not null column.';

COMMENT ON COLUMN sal_grades.highest_sal
         IS 'Highest salary in the grade range. A not null column.';
