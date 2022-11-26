/* Advanced Subqueries
================================================================================
Lesson Objectives: After this lesson you will be able to:
================================================================================
-Understand correlated subqueries
-Use EXISTS operator with correlated subqueries
-Invoke Pairwise comparisons
-SELECT from a subquery in the FROM clause
-JOIN to a subquery
-Invoke the WITH clause for complicated queries
--------------------------------------------------------------------------------
CORRELATED SUBQUERIES
  -The correlated subquery references column(s) from a table in the 
    outer query.
  -Correlated subqueries will not run on their own.
  -They are co-related or co-dependent on the outer query.
  -The outer query begins the process.  */
--------------------------------------------------------------------------------
  --Who earns more than the average salary of their job?  
--------------------------------------------------------------------------------
  
  SELECT last_name, salary, job_id
    FROM employees e
    WHERE salary > (SELECT avg(salary) 
        						FROM employees
        						WHERE job_id = e.job_id);

--------------------------------------------------------------------------------
--Who has changed jobs at least twice in the past?
--------------------------------------------------------------------------------

  SELECT employee_id, last_name, job_id
    FROM employees e
    WHERE 2 <= (SELECT count(*) 
                  FROM job_history
                  WHERE employee_id = e.employee_id);
/*
--------------------------------------------------------------------------------
EXISTS
  -The EXISTS operator can be used with correlated subqueries.
  -Its original intent was to make correlated subqueries more efficient */
--------------------------------------------------------------------------------
 --Show all the managers
--------------------------------------------------------------------------------

  SELECT employee_id, last_name, job_id
    FROM employees e
    WHERE EXISTS (SELECT 'x' 
                    FROM employees
                    WHERE manager_id = e.employee_id);

/*
--------------------------------------------------------------------------------
NOT EXISTS
  -NOT EXISTS turns true into false and vice versa. */
--------------------------------------------------------------------------------
--Which departments are currently empty of any employees?
--------------------------------------------------------------------------------

  SELECT department_id, department_name
    FROM departments d
    WHERE NOT EXISTS (SELECT 'x'
                        FROM employees
                        WHERE department_id = d.department_id);
/*
--------------------------------------------------------------------------------
PAIRWISE COMPARISON
  -Sometimes a correlated subquery can be avoided using pairwise comparison
    with an uncorrelated subquery.
--------------------------------------------------------------------------------
  -Who earns the lowest salary in their department?
  -This can be answered using a correlated subquery or PAIRWISE COMPARISON.  */
--------------------------------------------------------------------------------
 --Correlated Subquery: 
  SELECT last_name, salary, department_id
    FROM employees e
    WHERE salary = (SELECT min(salary)
                      FROM employees
                      WHERE department_id =	 e.department_id)
    ORDER BY 3;

 --PAIRWISE COMPARISON:
  SELECT last_name, salary, department_id
    FROM employees 
    WHERE (department_id, salary) IN (SELECT department_id, min(salary)
                                        FROM employees
                                        GROUP BY department_id)
    ORDER BY 3;
/*
--------------------------------------------------------------------------------
SELECT from a subquery in the FROM clause
  -A subquery in the FROM or JOIN clause is known as an inline view.
  -The outer query selects from the result created by the inline view.
  -Typically inline views are given a short alias.      */
--------------------------------------------------------------------------------
--Inline view is called "a"

  SELECT avg(dept_total)
    FROM (SELECT manager_id, sum(salary) as dept_total
      			FROM employees
        		GROUP BY manager_id) a;   
/*
--------------------------------------------------------------------------------
JOIN to a subquery
  -An inline view can also be joined to, just like a permanent view.
  -Here, departments table is joined to inline view c.      */
--------------------------------------------------------------------------------
SELECT d.department_name, c.city
  FROM departments d JOIN	(SELECT city, location_id
                             FROM locations join countries 
                             USING (country_id)
                             JOIN regions
                             USING (region_id)
                             WHERE region_id IN (3,4)) c
	ON d.location_id = c.location_id
  ORDER BY 1;
/*
--------------------------------------------------------------------------------
WITH Clause
--------------------------------------------------------------------------------
  -The with clause allows you to break down a complicated query
    into smaller pieces.
  -Inline views are created which can be combined in the final anonymous query.
--------------------------------------------------------------------------------
 -Which departments have a total salary above the average of all total salaries
    for all departments?        */
--------------------------------------------------------------------------------
  --Without using WITH:
  
  SELECT department_name, sum(salary)
    FROM employees e JOIN departments d
    ON e.department_id = d.department_id
    GROUP BY department_name
    HAVING sum(salary) > (SELECT avg(sum(salary))
                 					 FROM employees
                           WHERE department_id IS NOT NULL
                           GROUP BY department_id)
    ORDER BY 1;

/*Using the WITH clause:
  -A view called dept_totals selects all department names and their 
    total salaries.
  -Avg_all_depts view selects the average of 2nd column in dept_totals view.
  -Final query uses both inline views as input to display
    those departments whose total salary is above average: */
  
WITH dept_totals as (
		SELECT department_name, sum(salary)	as totpay
			FROM employees e JOIN departments d
			ON e.department_id = d.department_id
			GROUP BY department_name),
	avg_all_depts as (
		SELECT avg(totpay) as depts_avg
      FROM dept_totals)
--SELECT * FROM avg_all_depts;  
  SELECT *
    FROM dept_totals
    WHERE  totpay > (SELECT depts_avg
            						FROM avg_all_depts)
    ORDER BY 1;
