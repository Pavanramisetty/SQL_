/*
Using Single-Row Functions to Customize Output

Lesson Objectives: After this lesson, you should be able to:
==========================================================================================
- Know the difference between single-row and group functions
- Use character, number, and date functions
- Understand how Oracle handles date data
------------------------------------------------------------------------------------
                      Character Functions
                              / \
                Case Conversion   Character Manipulation
                  lower               concat    lpad
                  upper               substr    rpad
                  initcap             length    trim
                                      instr     replace
---------------------------------------------------------------------------------
Case Conversion Functions
---------------------------------------------------------------------------------
*/
  SELECT UPPER(first_name), LOWER(last_name), email, INITCAP(email)
      FROM employees
      WHERE last_name = 'Taylor';
      
/* What if the data in the last_name column is entered without respect for case?
ie:   taylor
      joneS
      Taylor
      SMITH
      taYloR
      evANs
      TAYLOR
 and we want to select ALL rows with last_name Taylor regardless of case?
 The following query will select only one row:
*/
  SELECT employee_id, last_name, department_id
    FROM employees
    WHERE last_name = 'Taylor';
    
-- The following query will select ALL the rows with last_name Taylor, 
-- regardless of case:  

  SELECT employee_id, last_name, department_id
    FROM employees
    WHERE INITCAP(last_name) = 'Taylor';
  
/*
---------------------------------------------------------------------------------
 Character Manipulation Functions
---------------------------------------------------------------------------------
  An example of each character manipulation function:
--------------------------------------------------------------------------------
*/
  SELECT first_name, last_name,CONCAT(first_name, last_name) AS name, 
    LENGTH(last_name), INSTR(last_name, 'a',1,1),  email, SUBSTR(email, 1,4) 
    FROM employees;
        
   SELECT REPLACE(phone_number, '.' , '-') AS us_phone,
        LPAD(phone_number, 14, '+1') AS global_phone, 
        TRIM(leading 'M' from last_name)
        FROM employees
        WHERE SUBSTR(last_name,1,1) = 'M';
-------------------------------------------------------------------------------
-- SUBSTR       
-------------------------------------------------------------------------------
    SELECT last_name, SUBSTR(last_name, -4,4) AS last_four
      FROM employees;
    
-- Assumes the full length  
    SELECT last_name, SUBSTR(last_name, 3) AS from_third_on
      FROM employees;
    
-------------------------------------------------------------------------------
-- INSTR       
-------------------------------------------------------------------------------      

SELECT last_name, INSTR(last_name, 'Ha', 1, 1)
      FROM employees
      WHERE last_name LIKE '%Ha%';

-- Find the second occurrence
    SELECT last_name, INSTR(last_name, 'a', 1,2) 
      FROM employees
      WHERE last_name LIKE '%a%';

-------------------------------------------------------------------------------    
-- TRIM
-------------------------------------------------------------------------------
    SELECT email, TRIM(LEADING 'S' FROM email)
      FROM employees
      WHERE email like 'S%S';
      
    SELECT email, TRIM(TRAILING 'S' FROM email)
      FROM employees
      WHERE email like 'S%S';
    
-- BOTH is the default. It can be left out.
    SELECT email, TRIM('S' FROM email)
      FROM employees
      WHERE email like 'S%S';
      
    
    SELECT TRIM(' ' FROM '   Sammy  ') AS no_spaces
      FROM dual;

-------------------------------------------------------------------------------     
-- REPLACE     
-------------------------------------------------------------------------------
    SELECT last_name, REPLACE(last_name, 'a', 'o')
      FROM employees
      WHERE last_name LIKE '%a%';
--------------------------------------------------------------------------------
--Number Functions
--------------------------------------------------------------------------------
-- TRUNC VS ROUND
--------------------------------------------------------------------------------
    SELECT ROUND(165.87, 1)
        FROM dual;
        
    SELECT TRUNC(165.87, 1)
        FROM dual;
        
-- 0 places past the decimal is the default    
    SELECT ROUND(165.87)
        FROM dual;
        
    SELECT TRUNC(165.87)
        FROM dual;

-- To the closest tens
    SELECT ROUND(165.87, -1)
        FROM dual;
        
    SELECT TRUNC(165.87, -1)
        FROM dual;
        
-- To the closest hundreds
    SELECT ROUND(165.87, -2)
        FROM dual;
        
    SELECT TRUNC(165.87, -2)
        FROM dual;

--------------------------------------------------------------------------------
-- MOD returns the remainder of division.
--------------------------------------------------------------------------------
    SELECT last_name, salary, ROUND(salary / 1100,2), MOD(salary,1100)
      FROM employees;
--------------------------------------------------------------------------------
-- Working with dates
--------------------------------------------------------------------------------
-- DD-MON-RR
--------------------------------------------------------------------------------
/* Oracle displays dates in the DD-MON-RR format
   RR assumes: a year from  00-49 is from this century
               a year from  50-99 is from the last century
*/
  
  SELECT last_name, hire_date
    FROM employees
    WHERE hire_date > '31-DEC-06';
    
  SELECT *
    FROM JOB_HISTORY
    WHERE START_DATE <= '01-JAN-05';
    
-- Has anybody worked here more than 70 years?
    SELECT last_name, hire_date
      FROM employees
      WHERE hire_date < '01-NOV-49';
    
-- Every row was selected. Try using a four-digit year in the WHERE clause:
    
    SELECT last_name, hire_date
      FROM employees
      WHERE hire_date < '01-NOV-1949';
      
--------------------------------------------------------------------------------
--Arithmetic with dates
--------------------------------------------------------------------------------
  SELECT sysdate + 1 AS tomorrow
    FROM dual;
    
  SELECT hire_date, HIRE_DATE - 7 AS one_week_before_start_date
    from employees;
    
  SELECT employee_id, end_date - start_date AS days_in_previous_job
      FROM job_history
      ORDER BY 1;
      
  SELECT last_name, (sysdate - hire_date) / 7 AS weeks_on_the_job
    FROM employees;
    
  SELECT Last_name, (sysdate - hire_date) / 365.25 AS years_on_the_job
    FROM employees;
    
-- Better yet:
  SELECT Last_name, ROUND((sysdate - hire_date) / 365.25, 2) AS years_on_the_job
    FROM employees;
    
--------------------------------------------------------------------------------
-- Date Functions
--------------------------------------------------------------------------------
--How many months have employees worked here?
  SELECT last_name, MONTHS_BETWEEN(sysdate, hire_date) AS months_on_job
    FROM employees;
    
-- When was employee's six month anniversary?
  SELECT last_name, hire_date, ADD_MONTHS(hire_date, 6) AS six_month_anniv
    FROM employees;
    
-- If every Friday is payday, when was the first payday?
  SELECT last_name, hire_date, NEXT_DAY(hire_date, 'Friday') AS first_payday
    FROM employees;
    
-- Benefits begin on the first day of the month after hire date
  SELECT last_name, hire_date, LAST_DAY(hire_date) + 1 AS bene_day
    FROM employees; 
    
--------------------------------------------------------------------------------    
-- ROUND VS TRUNC with dates
--------------------------------------------------------------------------------
-- Month
--------------------------------------------------------------------------------
  SELECT hire_date, ROUND(hire_date, 'Month')
    FROM employees;
    
  SELECT hire_date, TRUNC(hire_date, 'Month')
    FROM employees;
--------------------------------------------------------------------------------    
-- Year  
--------------------------------------------------------------------------------
  SELECT hire_date, ROUND(hire_date, 'Year')
    FROM employees;
    
  SELECT hire_date, TRUNC(hire_date, 'Year')
    FROM employees;
    
    