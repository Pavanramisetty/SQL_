--------------------------------------------------------------------------------
/*        JOINS
--------------------------------------------------------------------------------
        -Natural Join           <----------------------
        -Join Using                                   | 
        -Join on                                      |
          --Equijoin                                  |
          --3 Way Join                                |
          --Extra Conditions                          |
          --Non-Equijoins                             |
          --Self Joins                                |---- ANSI SQL
          --Outer Join                                |
            ---Left outer Join                        |
            ---Right Outer Join                       |
            ---Full Outer Join                        |
        -Cross Join             <----------------------
        
        -Non-ANSI Join
================================================================================
Lesson Objectives: After this lesson, you should:
================================================================================
- Know when to use NATURAL JOIN, JOIN USING, JOIN ON
- Be able to use OUTER JOINS to see matching and non-matching data
- Know how to create Cartesian products with CROSS JOIN
- Understand why you should avoid writing Non-ANSI joins.
--------------------------------------------------------------------------------
NATURAL JOIN
  Joins tables based on ALL columns that have the same names among the tables.
-------------------------------------------------------------------------------
*/
  SELECT street_address, city, country_name 
      FROM locations NATURAL JOIN countries;
      
/* Its advantage is the succinct code. Its disadvantage is that the keys must 
   have the exact same name. Also, the implied join condition CANNOT be changed. 
    
    The following example will not produce meaningful results. */
  
  SELECT last_name, department_name 
      FROM employees NATURAL JOIN departments;
      
/*  The tables are joined on department_id AND manager_id. However, we only want
    to join them on department_id. The result is incomplete and CANNOT be changed.  

--------------------------------------------------------------------------------
JOIN USING
  Joins tables using the common key name(s) between the tables.
  Its advantage is that the code is shorter than JOIN ON. 
  The disadvantage is that the keys must have the same exact name.
*/
--------------------------------------------------------------------------------  
  SELECT country_name, region_id, -- Do not use table name qualifier.
        region_name
      FROM countries JOIN regions USING(region_id);
/*
  
--------------------------------------------------------------------------------
JOIN ON
  --Joins on whatever keys you specify. It is capable of inner and outer joins, 
  --and is the most flexible way to join tables. Its only disadvantage is that it can be wordy.*/
--------------------------------------------------------------------------------
  --Four table equijoin with extra condition
    SELECT last_name, department_name, city, country_name
      FROM employees e JOIN departments d ON e.department_id = d.department_id
      JOIN locations l ON d.location_id = l.location_id
      JOIN countries c ON l.country_id = c.country_id
      AND department_name IN('Finance', 'Sales' , 'Shipping');
      
--------------------------------------------------------------------------------     
 --Tables with self-referntial foreign keys can be joined to themselves. The
 --result is a hierarchy:
    
  SELECT e.employee_id, e.last_name as emp, e.job_id as emp_job, 
      b.last_name as boss, b.job_id as boss_job
    FROM employees e JOIN employees b ON e.manager_id = b.employee_id
    ORDER BY e.employee_id;
/*
--------------------------------------------------------------------------------
  OUTER JOINS
--------------------------------------------------------------------------------
The table to the left of the keyword JOIN is considered to be the left table, 
and the table to the right of the keyword JOIN is the right table.
*/

  SELECT city, department_name
    FROM locations d  LEFT JOIN departments l ON d.location_id = l.location_id;

  SELECT street_address, city, country_name
    FROM locations l RIGHT JOIN countries c ON l.country_id = c.country_id;
  
  SELECT last_name, department_name
    FROM employees e full join  departments d ON e.department_id = d.department_id;
	
---------------------------------------------------------------------------------------------------	
/*
CROSS JOIN
    -Will create a Cartesian Product on demand.
    -It is useful for brainstorming sessions if the tables are small.
    -Be aware that if the output is too big, it may be hard to work with.
    -If the output is too big, the DBAs will not be happy!  */
--------------------------------------------------------------------------------   
    --This CROSS JOIN creates 2,889 rows of output.
    --The result is too big for brainstorming.
     
     SELECT last_name, department_name
        FROM employees CROSS JOIN departments;
        
    --By adding a where clause the, result is more managable
      
     SELECT last_name, department_name
        FROM employees e CROSS JOIN departments
        WHERE e.department_id = 30;
            
--------------------------------------------------------------------------------    
/*    
--------------------------------------------------------------------------------
NON-ANSI JOINS
  Will create a partial or full Cartesian Product if the join conditions are 
  missing. This type of join should be avoided. */
--------------------------------------------------------------------------------   
              
        SELECT last_name, department_name, city
          FROM employees e, departments d, locations l
          WHERE e.department_id = d.department_id
          AND d.location_id = l.location_id;
		  
		  
/*  With a partial join condition, the query creates a partial Cartesian 
        Product with 2438 rows. No error message is created. */
    
      SELECT last_name, department_name, city
        FROM employees e, departments d, locations l
        WHERE e.department_id = d.department_id;
      
-------------------------------------------------------------------------------     
/*	  With no join conditions, this query still runs,
      creating a full Cartesian Product of over 72,000 rows! */
    
      SELECT last_name, department_name, city
        FROM employees, departments, locations;
        
     
    