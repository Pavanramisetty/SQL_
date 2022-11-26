/*
RETRIEVE DATA USING THE BASIC SELECT STATEMENT
================================================================================
Lesson Objectives: After this lesson, you should be able to effectively use:
================================================================================
-Basic SELECT statement
-Arithmetic Expressions
-Nulls
-Column Aliases
-Concatenation
-Literals
-DISTINCT keyword
-Quotation Marks
-DESCRIBE SQL Developer command
--------------------------------------------------------------------------------
Basic Select Statement
--------------------------------------------------------------------------------
 -Format:  SELECT column1, column2, column3, etc.
             FROM table_name;
*/
--------------------------------------------------------------------------------

  SELECT employee_id, first_name, last_name, hire_date
    FROM employees ;			

/*    
--------------------------------------------------------------------------------
Selecting ALL Columns:
 -You can display all columns of data in a table by using *
*/
--------------------------------------------------------------------------------
  SELECT * 
    FROM employees;

/*
--------------------------------------------------------------------------------
Arithmetic Expressions are created using: 
	+   Addition
	-   Subtraction
	*   Multiplication
	/   Division
	
*/
--------------------------------------------------------------------------------

SELECT employee_id, last_name, salary, salary + 500
	FROM employees;

/*
--------------------------------------------------------------------------------
Operator Precedence
  -Which math operator occurs first?    */
--------------------------------------------------------------------------------
  
  SELECT employee_id, last_name, salary, salary + 500 * 12
    FROM employees;

  SELECT employee_id, last_name, salary, (salary + 500) * 12
    FROM employees;
/*   
--------------------------------------------------------------------------------
  -With Date and Timestamp data, the addition + and subtraction - operators may
    be used.
  -Numbers added to or subtracted from a date or timestamp are assumed to 
    represent a number of days.     */
--------------------------------------------------------------------------------    
    
  SELECT hire_date, hire_date + 61 
      from employees;

/*
--------------------------------------------------------------------------------      
Defining Nulls
  -A null is a value that is unavailable, unassigned, unknown, and inapplicable.
  -Null is not the same as a blank space or zero. */
--------------------------------------------------------------------------------

  SELECT department_name, manager_id, location_id
    FROM departments;
/*  
--------------------------------------------------------------------------------  
Nulls in Arithmetic Expressions
 -Arithmetic expressions containing nulls evaluate to null. */
--------------------------------------------------------------------------------

SELECT employee_id, salary, commission_pct, 12 * salary * commission_pct
  FROM employees;
/*
--------------------------------------------------------------------------------
Column Aliases
---- Provide a custom output column heading
---- Are useful with calculations
---- Immediately follow the column name. The optional keyword AS should be used.
---- Require double quotes if they:
		--- Are case sensitive 
		--- Do not start with a letter
		--- Are an Oracle reserved word
		--- Contain any characters other than
				-- Letters
				-- Numbers
				-- $_#          
*/
--------------------------------------------------------------------------------
  
  SELECT employee_id, first_name as fname , last_name as lname, manager_id as "Boss"
    FROM employees;
  
  SELECT employee_id, salary * 12 as yearly_pay
    FROM employees;

/*  
--------------------------------------------------------------------------------
Concatenation 
 -The conatenation operator || abuts columns and literal values into a character 
  output column. */
--------------------------------------------------------------------------------

SELECT employee_id || last_name as employee
	FROM employees;

/* 
--------------------------------------------------------------------------------
Literal Values 
 -A literal is a number, character, or date that is included in the SELECT statement.
 -Date and character literal values must be enclosed within single quotation marks.
 -Each literal is output once for each row returned. */
-------------------------------------------------------------------------------- 

SELECT department_name, 'Hello'
	FROM departments;
	
SELECT country_name, 50
	FROM countries;
	
SELECT '01-JAN-15', region_name
	FROM regions;
	
--Combine columns and literals with concatenation:

SELECT 'Location ' || location_id || ' is in ' || city as Location_and_city
  FROM locations;
  
SELECT last_name || ' works for boss ' || manager_id as boss
  FROM employees;
  
/* 
--------------------------------------------------------------------------------
Quotations
 -SQL uses single quotes, or tick marks, with character and date data.
 -Quotation marks in SQL must be paired.
 */
--------------------------------------------------------------------------------
-- The following query fails:

--  SELECT department_name || ' Department's boss is ' || manager_id as Dept_and_mgr
--    FROM departments;

-- Do you know why?  
--------------------------------------------------------------------------------
--Use two single quotes, or ticks, in a row to display the apostrophe:
--Please comment out lines 155 and 156.

SELECT department_name || ' Department''s boss is ' || manager_id as Dept_and_mgr
  FROM departments;
  
/* 
--------------------------------------------------------------------------------
Deduplicating Output Rows
 -To eliminate duplicate output rows, use the DISTINCT keyword after SELECT. */
--------------------------------------------------------------------------------
  
  SELECT  job_id
    FROM employees;

  SELECT DISTINCT job_id
    FROM employees;
  
/* 
--------------------------------------------------------------------------------
DISTINCT affects all selected columns. 
  -The second result below will show every DISTINCT combination of employee_id
   and department_id. Compare the two result sets. */
--------------------------------------------------------------------------------
  SELECT job_id, department_id
    FROM employees;
	
  SELECT DISTINCT job_id, department_id
    FROM employees;
/* 
--------------------------------------------------------------------------------
DESCRIBE command
 -Use the describe, or desc Oracle tool command to display the structure of a table.
 -It is especially useful when you are not in a GUI environment like SQL Developer
 -If tables are large, it is not practical to use SELECT * FROM table_name;
  */
--------------------------------------------------------------------------------
desc departments

--The output is similar to clicking on the table name in SQL Developer.
--Note that a tool command does not require ; because it is not SQL.
  