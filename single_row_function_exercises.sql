/*Look through Lesson 07b Single-Row Functions Part 1.sql and run the code examples there, then
   practice single-row functions with the excercises below:
*/

/* 1) Display the first_name, last_name, and the first four letters of 
      the first name with the last four letters of the last name of 
      each employee in department 50. Label the column SHORT_NAME. */
      SELECT first_name, last_name, concat(substr(first_name, 1, 4) , substr(last_name, -4, 4)) AS SHORT_NAME
          FROM employees
              WHERE DEPARTMENT_ID = 50;

/* 2) Display the employee number, last_name, salary, and salary increased by
      4.8125% for each employee. Round the result two places past the decimal 
      and label the column NEW_PAY. */
      SELECT employee_id, last_name, salary, (salary + Round(4.8125)) AS NEW_PAY
          FROM employees;


/* 3) Repeat query 2 but add a column that subtracts the old salary from the
      new salary. Label the column PAY_INCREASE. */
      SELECT employee_id, last_name, salary, ((salary + Round(4.8125)) - salary) AS PAY_Increase
          FROM employees;

/* 4) Display the last name, length of the last name, for any employee
      whose last name begins with A, J, or M. Give each column an appropriate
      alias. */
      SELECT last_name, LENGTH(last_name)
          FROM employees
              WHERE substr(last_name, 1, 1) IN ('A', 'J', 'M');

/* 5) Rewrite the previous query to prompt the user to enter a letter that the 
      last name starts with. */ 
      SELECT last_name, LENGTH(last_name)
          FROM employees
              WHERE substr(last_name, 1, 1) IN ('&lastnamestartswith');      
      

/* 6) Show the last name and the number of months each employee has worked.
      Label the column MONTHS_WORKED. Trunc the number of months to the 
      closest whole number. */
      SELECT last_name, trunc((sysdate - hire_date)/12) as months_worked
          FROM employees;
    
/* 7) Show the last name and salary of all employees. Display a 
      fixed dollar sign concatenated with the salary padded with asterisks 
      up to a width of 9 characters.  Label the column SALARY. */
      SELECT last_name, salary, rpad(concat('$' , salary), 9,'*') AS SALARY
          FROM employees;
      


/* 8) Display the last_name, and the number of weeks each employee has worked
      in department 90. Label the column TENURE. Trunc the number of weeks
      zero places past the decimal. Sort the result in descending order of
      tenure. */
      SELECT last_name, trunc((sysdate - hire_date)/7, 0) AS Tenure
          FROM employees
          WHERE department_id = 50
          ORDER BY Tenure DESC;
    
      
/* 9) Show the characters in the street address in the locations table beginning
      with the character after the first space. For example, if the address is 
      10 Downing Street, just show Downing Street. Label the column street.*/
      SELECT street_address, substr(street_address, INSTR(street_address, ' ', 1)) AS street
          FROM locations;
                 
        
/* 10) Display last name, the date of their first performance review, and the
       number of months the employee has worked. The first review occurred six 
       months after being hired. Round the months two places, and label the 
       columns first_review and tenure. */
        SELECT last_name,ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE),2)AS tenure,ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)+6,2) AS first_review
        FROM employees;
       
       
/* 11) Show last name, manager, job, hire date, date of first paycheck, and the date
        benefits began. Paychecks are paid each Friday and benefits begin
        the first day of the month after hire. Label the columns first_payday,
        and benefits_start. */ 
        --SELECT last_name, manager_id, job_id, hire_date,     
        SELECT last_name,manager_id,job_id,hire_date,NEXT_DAY(hire_date,'Friday') AS first_payday,ROUND(hire_date,'Month') AS benefits_start
        FROM employees; 
       
       