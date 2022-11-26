/* BASIC SUBQUERIES
================================================================================
Lesson Objectives: After this lesson, you should:

- Know when to use subqueries
- Be able to work with subqueries in the WHERE clause to write:
    >Single-row subqueries
    >Multi-Row subqueries
- Understand how to write subqueries in the HAVING clause
- Know how to work with a subquery that returns nulls 
================================================================================
Subqueries can easily answer two questions at once:
  Which office locations are in the countries of the European region?
    Question 1 - Which locations?
    Question 2 - What are the European countries?
--------------------------------------------------------------------------------
  Solution:
*/
    SELECT street_address, city, country_id       --Which are the locations?
        FROM locations
        WHERE country_id IN (SELECT country_id    --What are the country_ids?
                              FROM countries
                              WHERE region_id = 1);
                              
/* The query above requires you to already know the region_id of Europe. Suppose
    you don't know this value. The query could be written as follows:
*/
    SELECT street_address, city, country_id       --Which are the locations?
        FROM locations
        WHERE country_id IN (SELECT country_id    --What are the country_ids?
                              FROM countries
                              WHERE region_id = (SELECT region_id  --Europe's id?
                                                    FROM regions
                                                    WHERE region_name = 'Europe'));
/*
--------------------------------------------------------------------------------                                                    
More reasons to use SUBQUERIES:
--------------------------------------------------------------------------------
  -The data could be dynamic in the locations and countries tables with new 
   offices opening on a regular basis.
  -It's not a part of your job to know all the global locations.
  -You want your queries to be easier to read and understand than using
    hard-coded literals such as region_id = 1.
  -You want to use a technique other than a join to retrieve multi-table data.
*/
--------------------------------------------------------------------------------
--The previous example could have been written as a three-table join:

  SELECT street_address, city, l.country_id       
        FROM locations l JOIN countries c ON l.country_id = c.country_id
        JOIN regions r on c.region_id = r.region_id
        AND r.region_id = 1;
/*        
--------------------------------------------------------------------------------
Subqueries in the WHERE clause:
--------------------------------------------------------------------------------
There is no limit to the number of subqueries that can be written in a compound
where clause to avoid using literal values:
*/
  SELECT * 
  FROM employees 
  WHERE commission_pct = (SELECT commission_pct 
                            FROM employees 
                            WHERE employee_id = 171)
  AND salary < (SELECT salary 
                  FROM employees 
                  WHERE employee_id = 171)
  AND manager_id = (SELECT manager_id 
                      FROM employees 
                      WHERE employee_id = 171);

--------------------------------------------------------------------------------
--Subqueries allow you to circumvent the rule that prohibits group functions
--in the WHERE clause:
--------------------------------------------------------------------------------
    SELECT *
      FROM sales
      WHERE sales_amt = MAX(sales_amt);       --WILL NOT WORK
                      
    SELECT *
      FROM sales
      WHERE sales_amt = (SELECT max(sales_amt)
                          FROM sales);
/*
--------------------------------------------------------------------------------
Subqueries in the HAVING clause
--------------------------------------------------------------------------------
The having clause is designed to specify which groups of aggregated data to return.
Because its syntax is similar to WHERE, it easily works with subqueries:
*/
SELECT job_id, MAX(salary)
      FROM employees
      GROUP BY job_id
      HAVING MAX(salary) >= (SELECT MAX(salary)
                              FROM employees
                              WHERE job_id = 'SA_REP');

--------------------------------------------------------------------------------
-- In Lesson 10b Aggregating Data Using Group Functions.sql, 
-- you saw how group functions can be nested:

    SELECT MAX(AVG(salary))
      FROM employees
      GROUP BY department_id;
      
/*  The above query displays the largest average salary after the average salaries
    are grouped by department_id. What if we want to see the department id that 
    corresponds to this average salary? The following query fails.*/
  
    SELECT department_id, MAX(AVG(salary))
      FROM employees
      GROUP BY department_id;
      
--A subquery in the HAVING clause using nested group functions will solve the problem:

    SELECT department_id, AVG(salary) as largest_avg_Pay
      FROM employees
      GROUP BY department_id
      HAVING AVG(salary) = (SELECT MAX(AVG(salary))    --highest avg(salary) by department
                              FROM employees
                              GROUP BY department_id); -- avg(salary) is grouped by department_id
                              
--------------------------------------------------------------------------------
--Be careful when a subquery selects nulls
--------------------------------------------------------------------------------

--Who is a boss?
    SELECT last_name
      FROM employees
      WHERE employee_id IN (SELECT manager_id       --The subquery result has a NULL row
                              FROM employees);
                              
  --Who is NOT a boss? There shoeuld be about 90 rows of output.
      SELECT last_name
      FROM employees
      WHERE employee_id NOT IN (SELECT  manager_id
                                  FROM employees);
                                  
  /*The NULL must be removed from the inner query result for the outer query to
    work correctly:
  */
      SELECT last_name
      FROM employees
      WHERE employee_id NOT IN (SELECT manager_id
                                  FROM employees
                                  WHERE manager_id IS NOT NULL);
/*
================================================================================
SUMMARY
================================================================================
You have now seen:
-The many reasons to use subqueries including
  --A need to answer more than one question at a time
  --Writing queries that reference dynamic data
  --A where clause that needs to reference a group function
-How to write subqueries that return exactly one row
-How to write subqueries that return many rows
-Subqueries in the HAVING clause to include/exclude groups
-The need to remove nulls when using NOT IN before a subquery
