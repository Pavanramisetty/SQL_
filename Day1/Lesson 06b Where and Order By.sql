/*
RESTICT AND SORT DATA
Lesson Objectives: After this lesson, you should be able to:
==========================================================================================
-Limit rows that are selected using the WHERE clause
-Sort selected rows using the ORDER BY clause
-Use & and && Substitution Variables to complete statements at run time
-------------------------------------------------------------------------------------------
The WHERE clause
-------------------------------------------------------------------------------------------

 Format: SELECT column1, column2, column3, etc
          FROM table name
          WHERE condition(s);
          
*/
--------------------------------------------------------------------------------
-- Restrict rows displayed based on the value in a NUMBER column:

	SELECT employee_id, first_name, last_name, job_id, manager_id
		FROM employees 
		WHERE manager_id = 108;   -- No quotes, or ticks, with numbers

  
/*   Character strings and dates are enclosed in single quotation marks.
     Character values are case-sensitive and date values are format-sensitive. 
     Restrict rows based on DATE and CHARACTER columns:   */

    SELECT last_name, job_id, department_id
      FROM employees
      WHERE job_id = 'FI_ACCOUNT';  -- Use quotes, or ticks, with chaacter values
    
    SELECT last_name, job_id, hire_date
      FROM employees
      WHERE hire_date < '01-JAN-10'; -- Use quotes, or ticks, with date values.
--------------------------------------------------------------------------------      
--Why do the following two queries return no rows?

  SELECT location_id, city
    FROM locations
    WHERE street_address = '12-98 VICTORIA STREET' ;
  
  SELECT *
  FROM employees
  where hire_date < 'January 1, 2000' ;
-------------------------------------------------------------------------------- 
  
/*  COMPARISON OPERATORS
  The following six operators can have only ONE value on the right side:
  
	=         Equal to
  != <> ^=  Not equal to
	>         Greater than
	>=        Greater than or equal to
  <         Less than
	<=        Less than or equal
  
  The following four operators can compare to multiple values and can easily 
  be used with the NOT keyword:
  
  BETWEEN...AND
  IN
  LIKE
  IS NULL
*/
--------------------------------------------------------------------------------
SELECT last_name, salary
	FROM employees
  WHERE salary BETWEEN 3000 AND 3500; --Inclusive range
  
  SELECT employee_id, last_name, salary, manager_id
    FROM employees
    WHERE manager_id IN (148, 149, 201); -- = to many values
  
  SELECT country_name
    FROM countries
    WHERE country_name LIKE 'United%';  --Character data column
    
  SELECT last_name, hire_date
    FROM employees
    WHERE hire_date  LIKE '%05';   -- Date data column
    
  SELECT department_name, location_id
    FROM DEPARTMENTS
    WHERE location_id LIKE '_7%';   --Number data column
    
  SELECT * 
    FROM departments
    WHERE manager_id IS NULL;
    
-- The following query fails because nulls are not equal to anything.
-- The concept of equality does not apply to nulls:
  
  SELECT department_name, manager_id, location_id
    FROM departments
    WHERE manager_id = NULL;  --Must use IS NULL
--------------------------------------------------------------------------------
/* LOGICAL OPERATORS
    AND - Returns true if both conditions are true
    OR  - Returns true if either condition is true
    NOT - Returns true if the condition is false
*/

SELECT employee_id, last_name, job_id, salary
	FROM employees
  WHERE salary >= 10000 OR job_id LIKE '%MAN'; -- OR is inclusive

SELECT employee_id, last_name, job_id, salary
	FROM employees
  WHERE salary >= 10000 AND job_id LIKE '%MAN'; --AND is exclusive
  
SELECT last_name, job_id
	FROM employees
  WHERE job_id NOT IN ('IT_PROG' , 'ST_CLERK' , 'SA_REP');
  
 SELECT last_name, salary, commission_pct
    FROM employees
    WHERE commission_pct IS NOT NULL;
  
--NOT flips true to false and false to true
--------------------------------------------------------------------------------
/*  Rules of precedence 

    Priority    Operator
      1           NOT
      2           AND
      3           OR
*/
  -- Whatever conditions surround AND are evaluated first:
  SELECT last_name, job_id, salary
    FROM employees
    WHERE job_id = 'SA_REP' OR job_id = 'AD_PRES' AND salary > 15000;
    
  -- Change the default priority with parentheses().  
  SELECT last_name, job_id, salary
    FROM employees
    WHERE (job_id = 'SA_REP' OR job_id = 'AD_PRES') AND salary > 15000;
  
------------------------------------------------------------------------------
-- ORDER BY
------------------------------------------------------------------------------

/*  Sort rows with the ORDER BY clause.
    The ORDER BY clause is last in the basic SELECT statement. */

--ASC is the default order:

SELECT last_name, job_id, department_id, hire_date
    FROM employees
    ORDER BY hire_date; 
    
SELECT job_id, last_name, department_id, hire_date
    FROM employees
    ORDER BY job_id, last_name;

--Rows can be sorted in descending order:

SELECT last_name, job_id, department_id, hire_date
    FROM employees
    ORDER BY department_id DESC, last_name;  
    
--Order by a column alias:
 
SELECT employee_id, last_name, salary * 12 as yearly_pay
    FROM employees
    ORDER BY yearly_pay;  
       
--Order by column's numeric position:
  
  SELECT last_name, job_id, department_id, hire_date
    FROM employees
    ORDER BY 3;   
    
--Order by an unselected column:
  
  SELECT job_id, job_title
      FROM jobs
      ORDER BY max_salary;
-----------------------------------------------------------------------------
-- SUBSTITUTION VARIABLES
-----------------------------------------------------------------------------
/* Temporarily store values using single-ampersand &, and double-ampersand &&
   Substitution Variables.
   
   Use a variable prefixed with & to prompt the user for a value. The value
   provided will be used, and then discarded from session memory:
------------------------------------------------------------------------------
*/
    SELECT employee_id, last_name, salary, department_id
        FROM employees
        WHERE department_id = &deptno;  --No quotes, or ticks, for number data.
        
    SELECT last_name, department_id, salary * 12
        FROM employees
        WHERE job_id = '&jobid';        --Use quotes for character data.
        
    SELECT employee_id, last_name, job_id, &col_name
        FROM employees
        WHERE &condition
        ORDER BY &order_column;
  
--------------------------------------------------------------------------------    
/*  If you want to order by the fourth column of your choice, the following
    example is awkward:
--------------------------------------------------------------------------------
*/
  SELECT employee_id, last_name, job_id, &col4
      FROM employees
      ORDER BY &col4; -- Requires you to type in the same column again
      
-------------------------------------------------------------------------------        
/* && substitution variables are used when you want to reuse the value without 
    prompting the user each time. The value provided will be used, 
    and then saved into session memory: 
--------------------------------------------------------------------------------
*/
    SELECT employee_id, last_name, job_id, &&col4
      FROM employees
      ORDER BY &col4;

-------------------------------------------------------------------------------      
/* Run the above query a second time, and use a different column name. You will
    see the value is stored in session memory and will not change.
    
    Use the UNDEFINE Oracle tool command to clear the value from session memory
      before running the query a second time. You may have to highlight the 
      command in order for it to work correctly:
*/
  
  UNDEFINE col4
  
  SELECT employee_id, last_name, job_id, &&col4
      FROM employees
      ORDER BY &col4; 
      
------------------------------------------------------------------------------
/*
QUIZ
Which of the following are valid operators for the WHERE clause?

1.  >=
2.  IS NULL
3.  !=
4.  IS LIKE
5.  IN BETWEEN
6.  <>
  