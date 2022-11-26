--------------------------------------------------------------------------------
/*  GROUP FUNCTIONS
--------------------------------------------------------------------------------
        MIN 
        MAX
        SUM
        AVG
        COUNT
================================================================================
Lesson Objectives: After this lesson, you should:
================================================================================
- Know how to use GROUP functions to aggregate data
- Be able to group data into groups within groups 
- Understand how to include only certain groups in the output
- Know how to nest group functions inside each other.
--------------------------------------------------------------------------------
  Group Functions return one row of grouped, or aggreagated output data 
  for every group of input rows.
--------------------------------------------------------------------------------
*/
  SELECT MAX(salary), MIN(salary), AVG(salary), MAX(commission_pct),
      MIN(commission_pct), COUNT(salary), COUNT(commission_pct) 
      FROM employees
      WHERE department_id IN (50, 80);
      
--Notice how the AVG result should be rounded.      
/*
--------------------------------------------------------------------------------
  GROUP BY clause
--------------------------------------------------------------------------------
  In order to create groups of data, the GROUP BY clause must be used.
  The GROUP BY clause must be used when columns are selected next to 
  Group Functions. Thses columns are known as dimensions. 
*/
--------------------------------------------------------------------------------

  SELECT manager_id, SUM(salary)
      FROM employees
      GROUP BY manager_id
      ORDER BY 1;
  
--It is possible to use the Group By clause on columns that 
--are not selected:

  SELECT department_id, AVG(salary * commission_pct)
      FROM employees
      GROUP BY department_id;
-- The result is not very meaningful without the department_id   

--  ALL dimensions must be used in the GROUP BY clause:
  
  SELECT department_id, manager_id, SUM(salary)
      FROM employees
      GROUP BY department_id, manager_id
      ORDER BY 1,2;
      
-- What is wrong with the following query?

    SELECT job_id, COUNT(last_name) as headcount
      FROM employees;
      
-- The next query looks like it should run. What is it missing?

    SELECT department_id, manager_id, job_id, COUNT(*) as headcount
      FROM employees
      GROUP BY department_id, manager_id
      ORDER BY 1,2;
      
-- The following query is trying to restrict groups. Does it work?

      SELECT manager_id, SUM(salary)
        FROM employees
        WHERE SUM(salary) >= 50000
        GROUP BY manager_id;

--------------------------------------------------------------------------------
/*
  HAVING clause
  -You cannot use the WHERE clause to restrict groups.
  -Group functions are not allowed in the WHERE clause.
  -Instead, use the HAVING clause to restrict groups in your output.
*/
--------------------------------------------------------------------------------
--The query above will be changed to work correctly:

    SELECT manager_id, SUM(salary)
        FROM employees
        GROUP BY manager_id
        HAVING SUM(salary) >= 50000;

-- The HAVING clause can reference group functions that are not in the 
-- selection list:
    
    SELECT manager_id, MAX(salary)
        FROM employees
        GROUP BY manager_id
        HAVING AVG(salary) >= 8000;
        
-- The HAVING clause can use AND and OR logical operators:
      
    SELECT department_id, MAX(salary), MIN(salary)
      FROM employees
      GROUP BY department_id
      HAVING MAX(salary) > 20000 OR MIN(salary) < 5000
      ORDER BY 2 desc;

--------------------------------------------------------------------------------
-- Nesting Group Functions: 
-- Group Functions can be nested two levels deep.
--------------------------------------------------------------------------------
-- Display the lowest average salary of all the departments.    
      
    SELECT MIN(AVG(salary))
      FROM employees
      GROUP BY department_id;
      
/* 
    The above example calculates the average salary for each department and then
    displays only the smallest of those numbers. The GROUP BY clause must be used.

   What if you want to see which department_id corresponds to the above result?
   The following query will not work:
*/  
    SELECT department_id, MIN(AVG(salary))
      FROM employees
      GROUP BY department_ID;
      
/* 
    In Lesson 14b Advanced Subqueries.sql, you will tackle this problem.

================================================================================
 *SUMMARY*
================================================================================
    Remember two important rules about Group Functions:

  1) When you select columns next to group functions, you must GROUP BY all 
      those columns, known as dimensions. 
      The GROUP BY clause references those columns.
      
  2) When you need to restrict groups, do not use the WHERE clause. The WHERE 
      clause cannot reference Group Functions. Use the HAVING clause instead. 
      The HAVING clause references group functions.

--------------------------------------------------------------------------------    
    You have now learned all six basic clauses used in SELECT statements. 
    Let's review their purpose:

  SELECT  - specifies the columns of data you want displayed. REQUIRED.
  FROM    - specifies the source(s) of the data. REQUIRED.
  WHERE   - specifies which individual rows you want to process.
  GROUP BY - specifies how you want aggregated, or rolled-up, data to be grouped.
  HAVING  - specifies which of these groups to display.
  ORDER BY - specifies the order of the output rows.

  The folowing query uses one of each of the six basic clasues:
  */
        SELECT department_id, MAX(salary)
          FROM employees
          WHERE commission_pct IS NULL
          GROUP BY  department_id
          HAVING MAX(salary) >= 10000
          ORDER BY 1;

