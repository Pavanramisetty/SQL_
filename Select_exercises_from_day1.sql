/* Look through Lesson 05b Select Statement.sql and run the code examples there, then
   practice retrieving data using the SELECT excercises below:
*/
SELECT * FROM employees;

/* 1) Determine the structure of the departments table without 
      clicking the table name in the object tree. */
      DESCRIBE departments;

/* 2) Determine the structure of the employees table without 
      clicking the table name in the object tree. */
      DESC employees;
  
/* 3) Write a query that displays the employee id, last name, job id, and hire date
      for each employee. Provide a column alias STARTDATE for the hire date. */
      SELECT employee_id, last_name, job_id, hire_date AS STARTDATE
          FROM employees;
          
-- 4) Display all unique job ids in the employees table.
      SELECT DISTINCT job_id FROM employees;

/* 5) Rewrite the query in item 3 with more descriptive column headings.
      Name the column headings Emp #, Employee, Job, and Hire Date. */
      SELECT employee_id AS "Emp #", last_name "Employee lastname", job_id AS "Employee job id", hire_date AS STARTDATE
          FROM employees;
            
      
/* 6) Write a query that displays city concatenated with country id, separated
      by a comma and space. Name the column City and Country. */
      select city || ',' || ' ' || country_id AS "City and Country"
          FROM locations;
      
/* 7) Display employee number, last name, salary, and salary with an additional 
      $100 bonus multiplied by 12. Label the last column yearly_compensation. */
      SELECT employee_id, last_name, salary, (salary + 100) * 12 AS yearly_compensation
          from employees;
