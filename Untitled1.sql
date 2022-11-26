/*Look through Lesson 09b Single-Row Functions Part 2.sql and run the code examples there, then
   practice single-row functions with the excercises below:
*/
--Practice single-row functions - Part 2
--Datatype conversion and NULL functions and Conditional Expressions

/* 1) Create a report that produces the following for each employee as one
      column only: <employee's last name > earns <salary> monthly but wants
      <3 times salary.> Label the column Dream_Salaries. Ensure that money
      amounts appear with floating currency symbol, group separator, and
      decimal point with two digits past the decimal.*/
      SELECT (last_name || ' earns ' || salary || ' monthly but wants ' || '$' || salary * 3) AS DREAM_SALARIES
          FROM employees;

/* 2) Display each employee's last name, hire date, and first salary review date.
      Their first review was held the first Monday after they were with the 
      company twelve months. Label the column first_review. Display it in the
      format Monday, the Seventeenth of August, 2013. */
      SELECT last_name, hire_date, TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 12), 'Monday'), 'fmDay, "the" ddth "of" MONTH yyyy' ) as first_review
      FROM employees;

/* 3) Display the last name, hire date, and day of the week on which the 
      employee started. Label the column start_day. Order the result by day of 
      the week, starting with Sunday. */
      SELECT last_name, hire_date, TO_CHAR(hire_date, 'DAY') AS start_day
          FROM employees
          ORDER BY start_day;


/* 4) Display employee last names, and salary multiplied by commission percent
	  for employees in departments 60 and 80. Format the result of the multipliaction 
	  with a floating currency symbol, group separator, and decimal symbol.
	  If the employee does not earn a commission, show "No Commission". Label the column COMM. */
      SELECT last_name, salary,
        CASE WHEN department_id = 60 THEN ('$' || salary * commission_pct)
             WHEN department_id = 80 THEN ('$' || salary * commission_pct)
             WHEN commission_pct IS NULL THEN 'No Commission'
             END as COMM
                 FROM employees;


/* 5) Use the CASE expression to write a query that displays the last name, job id and grade
      of each employee based on their job id value. Use the following data:
      Job               Grade
      AD_PRES             A
      ST_MAN              B
      IT_PROG             C
      SA_REP              D
      ST_CLERK            E
      None of the above   N             */ 
     SELECT last_name, job_id,
        CASE job_id 	 WHEN 'AD_PRES'  THEN 'A'
                         WHEN 'ST_MAN' 	 THEN 'B'
                         WHEN 'IT_PROG'	 THEN 'C'
                         WHEN 'SA_REP'	 THEN 'D'
                         WHEN 'ST_CLERK' THEN 'E'
                         ELSE 'N' END AS grade
        FROM employees;


      
/* 6) Rewrite the previous query using the DECODE function instead of the CASE
      expression. */
     SELECT last_name, job_id,
        DECODE (job_id,  'AD_PRES', 'A',
                         'ST_MAN',  'B',
                         'IT_PROG', 'C',
                         'SA_REP',	'D',
                         'ST_CLERK', 'E',
                          'N') AS grade
        FROM employees;              
        