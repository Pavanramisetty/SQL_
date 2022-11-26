/*
MORE SINGLE-ROW FUNCTIONS
      -DATATYPE CONVERSION FUNCTIONS
        --TO_CHAR 
        --TO_DATE
      
	  -NESTING SINGLE-ROW FUNCTIONS
      
	  -NULL FUNCTIONS
        --NVL
        --NVL2
        
      -CONDITIONAL EXPRESSIONS
        --CASE Expression
        --DECODE Function
================================================================================
Lesson Objectives: After this lesson, you should:
================================================================================
- Know when to use datatype conversion functions
- Be able to nest functions as needed
- Understand how to use functions that work with nulls
- Know how to apply conditional expressions using the CASE expression 
    and DECODE function
--------------------------------------------------------------------------------
 DATATYPE CONVERSION FUNCTIONS: 
--------------------------------------------------------------------------------
 TO_CHAR WITH DATES - converts date data into character data for formatting and 
    and readability purposes.
--------------------------------------------------------------------------------
      Element     Result
      -------     ------
      YYYY        Four-digit year
      YEAR        Year spelled out - case sensitive
      MM          Two-digit month
      MONTH       Month spelled out - case sensitive
      MON         Three-letter abbreviated month - case sensitive
      DY          Three-letter abbreviated day of the week - case sensitive
      DAY         Day of the week spelled out - case sensitive
      DD          Numeric day of the month
--------------------------------------------------------------------------------
*/
  SELECT hire_date, TO_CHAR(hire_date, 'Month, Year') AS formatted_hire_date
      FROM employees
      WHERE department_id IN (10, 20, 30);
      
  SELECT hire_date, TO_CHAR(hire_date, 'Day, Mon dd, yyyy') AS formatted_hire_date
      FROM employees
      WHERE department_id IN (10, 20, 30);
      
  SELECT hire_date, TO_CHAR(hire_date, 'Dy, dd MON yy') AS formatted_hire_date
      FROM employees
      WHERE department_id IN (10, 20, 30);
/*
--------------------------------------------------------------------------------
      Element         Result
      -------         ------
      SYYYY           Year, server prefixes B.C. date with -
      YYY or YY or Y  Last three, two, or one digit of the year
      SYEAR           Year spelled out, server prefixes B.C. date with -
      AD BC           Indicates AD or BC as needed
      Q               Quarter of the year
      RM              Roman numeral month
      WW or W         Week of the year or month
      DDD or DD or D  Numeric Day of the year, month, or week
      J               Julian day. The number of days since December 31, 4713 BC
--------------------------------------------------------------------------------
*/
    SELECT TO_CHAR(SYSDATE,'RM dd yyyy') as formatted_date
      FROM dual;
      
    SELECT TO_CHAR(SYSDATE,'w, ww') as formatted_date
      FROM dual;
      
    SELECT TO_CHAR(SYSDATE,'D, DD, DDD') as formatted_date
      FROM dual;
    
    SELECT TO_CHAR(SYSDATE,'J') as julian_date
      FROM dual;
/*
--------------------------------------------------------------------------------
      Element               Result
      -------               ------
      AM or PM              Meridian Indicator
      HH or HH12 or HH24    Hour of day from 1-12 or 0-23
      MI                    Minutes 0-59
      SS                    Seconds 0-59
      SSSSS                 Seconds past midnight 0-86399
      / , .                 Punctuation reproduced in result
      "of the"              String is reproduced in result
      TH                    Ordinal number, example: DDTH is 24TH
      SP                    Spelled-out number, example: DDSP is TWENTY FOUR
      SPTH                  Spelled-out ordinal number, example: DDSPTH is
                              TWENTY FOURTH
--------------------------------------------------------------------------------
*/    
    SELECT TO_CHAR(SYSDATE,'DDth "of" Month') as formatted_date
      FROM dual;
    
    SELECT TO_CHAR(SYSDATE,'Ddsp "of" Month') as formatted_date
      FROM dual;
          
    SELECT TO_CHAR(SYSDATE,'Ddspth "of" Month') as formatted_date
      FROM dual;
      
    SELECT TO_CHAR(SYSDATE,'SSSSS') as seconds_since_midnight
      FROM dual;
      
    SELECT TO_CHAR(SYSDATE,'HH:MI:SS AM') as database_time
      FROM dual;
/*
--------------------------------------------------------------------------------
 DATATYPE CONVERSION FUNCTIONS: 
--------------------------------------------------------------------------------
 TO_CHAR WITH NUMBERS - converts number data into character data for formatting and 
    and readability purposes.
--------------------------------------------------------------------------------
      Element     Result
      -------     ------
      9           One digit. 
      0           Dislpays leading zeros
      $           Floating dollar sign
      ,           Comma
      .           Decimal point
      L           Local floating currency symbol
      G           Local group separator
      D           Local decimal symbol
--------------------------------------------------------------------------------
*/
    SELECT salary, TO_CHAR(salary, '$999,999.99') as formatted_salary
        FROM employees;
        
    SELECT salary, TO_CHAR(salary, '$099,999.99') as formatted_salary
        FROM employees;
        
    -- L, G, and D use the database country settings to determine which symbols 
    -- to display: 
      SELECT salary, TO_CHAR(salary, 'L999G999D99') as formatted_salary
        FROM employees; --L, G, and D use the database country settings
        
    SELECT commission_pct, TO_CHAR(commission_pct, '0.99') as formatted_commission
        FROM employees
        where commission_pct IS NOT NULL;
/*
--------------------------------------------------------------------------------
 DATATYPE CONVERSION FUNCTIONS: 
--------------------------------------------------------------------------------
 TO_DATE - converts characters into date data.
--------------------------------------------------------------------------------
Assume a user always types dates in the Month dd, yyyy format 
such as December 5, 2019. The folowing query will fail because the date on the
right side of the WHERE clause is not in the default DD-MON-RR format. The 
optimizer considers it to be a character string and not an actual date:             */
--------------------------------------------------------------------------------
    SELECT last_name, hire_date 
      FROM EMPLOYEES
      WHERE hire_date < 'January 15, 2005';  

--The query can be written using TO_DATE to translate the string into date data.
--The user can continue to use their usual format:
  
    SELECT last_name, hire_date 
      FROM EMPLOYEES
      WHERE hire_date < TO_DATE('January 15, 2005', 'Month dd, yyyy');

--------------------------------------------------------------------------------
--NESTING FUNCTIONS:
--------------------------------------------------------------------------------
--Can you figure out what the following example is diaplaying? 
  
    SELECT TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), 'Friday'),'fmDay, Month ddth, yyyy')
        as First_6_Month_review
      FROM employees;
        
--Note that fm removes extra spaces and leading zeros
/*
--------------------------------------------------------------------------------
  FUNCTIONS THAT WORK WITH NULLS:
--------------------------------------------------------------------------------
  NVL - Specifies output value if a null is encountered
  NVL2 - Specifies output values when nulls are encountered, and when they are
          not encountered
 --------------------------------------------------------------------------------  
*/
--NVL
  SELECT department_name, NVL(manager_id, 999) as manager_id
    FROM departments;
    
/*The following will fail. The column and substitution value must be of the 
  same datatype. Manager_id is a number column. The subtitution value must be 
  a number. */
  
  SELECT department_name, NVL(manager_id, 'No Boss') as manager_id
    FROM departments;
    
--This works. TO_CHAR casts manager_id as character data:
  
  SELECT department_name, NVL(TO_CHAR(manager_id), 'No Boss') as manager_id
    FROM departments;
    
--NVL2      
  SELECT last_name, salary, commission_pct,
        NVL2(commission_pct, salary+salary*commission_pct, salary)
      as gross_pay
    FROM employees
    WHERE department_id IN (60, 80);
     
/*
--------------------------------------------------------------------------------
 CONDITIONAL EXPRESSIONS:
--------------------------------------------------------------------------------
  Provide IF THEN ELSE logic within a SQL statement.
  -CASE expression is standard ANSI SQL. It is easy to understand.
  -DECODE function is ORACLE SQL. It requires less code, but is more cryptic 
    and harder to debug.
--------------------------------------------------------------------------------
*/

--CASE EXPRESSION
--The equality operator, =, is assumed.
  
    SELECT last_name, job_id,
        CASE job_id
        WHEN 'SA_REP' THEN 'Salesperson'
        WHEN 'SA_MAN' THEN 'Sales Manager'
        ELSE 'Not in Sales'         -- ELSE is optional
        END AS job_desc
      FROM employees
      WHERE department_id IN (60, 80);
      
--Searched CASE is used when an operator other than = must be used.
  
  SELECT last_name, salary, CASE  WHEN salary < 5000  THEN 'Too Low'
                                  WHEN salary < 10000 THEN 'Low'
                                  WHEN salary < 20000 THEN 'Medium'
                                  ELSE 'High'
                            END as Pay_level
      FROM employees;
    
--DECODE 
  
    SELECT last_name, job_id,
        DECODE (job_id,
        'SA_REP' , 'Salesperson' ,
        'SA_MAN' , 'Sales Manager' ,
        'Not in Sales')         -- optional
        AS job_desc
      FROM employees
      WHERE department_id IN (60, 80);
