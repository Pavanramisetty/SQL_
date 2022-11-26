SELECT * FROM employees;

--SELECT * | column1, column 2, etc
--	FROM table_name;

select * FROM departments;

select department_name, manager_id 
   FROM departments;

select last_name 
    FROM employees;
    
select SALARY, SALARY + 100 FROM employees; 

SELECT last_name, job_id, salary, commission_pct 
	FROM employees 
        WHERE COMMISSION_PCT is NULL;
        
SELECT SALARY + 200 AS increment_salary_bonus, salary AS Actual_salary 
   FROM employees;
   
SELECT LAST_NAME || SALARY as NAME_AND_SALARY_CLUB 
    FROM employees;
    
--SELECT region_name, 'HELLO', 6, '22-11-15' FROM regions;

SELECT first_name || ' salary is incremented 100' || first_name AS 
     incremented_salary FROM employees;
     
SELECT department_id FROM employees;

SELECT DISTINCT department_id FROM employees;

DESCRIBE employees;
DESCRIBE regions;



