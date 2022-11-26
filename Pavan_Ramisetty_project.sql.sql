--Question 1 
SELECT first_name, last_name, salary, job_id, department_name, city, country_name
    FROM departments d JOIN employees e
        ON d.department_id = e.department_id JOIN locations l
        ON d.location_id = l.location_id JOIN countries c
        ON c.country_id = l.country_id
           WHERE salary = (SELECT max(salary) FROM employees);
           
-- Question 2           
SELECT e.first_name, e.last_name, e.job_id, e.salary, e.manager_id 
    FROM employees e JOIN consultants c
        ON e.salary = c.salary
            WHERE e.job_id = c.job_id
            ORDER BY last_name;
            
--Question 3
SELECT cust_id, cust_fname, cust_lname, cust_city, NVL(max(s.sales_amt), 0) AS max_sale, 
        NVL(round(AVG(s.sales_amt), 2), 0) AS average_sales, count(s.sales_id) AS number_of_sales
        FROM customers c FULL OUTER JOIN sales s
            ON c.cust_id = s.sales_cust_id
                GROUP BY cust_id, cust_fname, cust_lname, cust_city
                    ORDER BY cust_id;

--Question 4
SELECT e.first_name, e.last_name, d.department_name, l.street_address, l.city, l.state_province
    FROM departments d JOIN employees e
        ON d.department_id = e.department_id JOIN locations l
        ON d.location_id = l.location_id
            WHERE d.manager_id = e.manager_id
                ORDER BY d.department_id;
            
--QUESTION 5
SELECT e.first_name AS employee_first_name, e.last_name employee_last_name, e.job_id AS employee_job_id, e.salary AS employee_salary, 
       m.first_name as manager_first_name, m.last_name AS manager_last_name, m.job_id as manager_job_id, m.salary as manager_salary
            FROM employees e JOIN employees m
                ON e.department_id = m.department_id
                    WHERE(e.employee_id != m.manager_id AND e.salary >= m.manager_id);
    
--QUESTION 6
SELECT e.employee_id, e.first_name, e.last_name, e.job_id, e.salary
    FROM employees e FULL OUTER JOIN job_history j
        ON e.department_id = j.department_id
            WHERE e.job_id = j.job_id;
        
--Question 7
SELECT DISTINCT e.first_name AS employee_first_name, e.last_name AS employee_last_name, e.job_id employee_job_id, e.salary AS employee_salary
	FROM employees e JOIN employees m
    ON e.department_id = m.department_id
    WHERE (e.employee_id != m.manager_id AND e.salary > ANY (SELECT e.salary 
                                                                from employees e JOIN employees m 
                                                                    ON e.department_id = m.department_id
                                                                        where e.employee_id = m.manager_id))
    ORDER BY e.salary;

--QUESTION 8
SELECT r.region_id, count(e.employee_id) AS employee_count
    FROM employees e JOIN departments d 
    ON e.manager_id = d.manager_id
        JOIN locations l
        ON l.location_id = d.location_id
            JOIN countries c
            ON l.country_id = c.country_id
                JOIN regions r 
                ON r.region_id = c.region_id
                        GROUP BY r.region_id;
                        --ORDER BY r.region_name;
    
--Question 9
UPDATE employees 
    SET FIRST_NAME = 'Kimberly', department_id = 80
    WHERE employee_id = 178;
    
UPDATE employees
    SET salary = (SELECT salary from employees
                  WHERE last_name = 'Ladwig')
    WHERE last_name = 'Stiles';
UPDATE employees
    SET salary = (SELECT salary from employees
                  WHERE last_name = 'Ladwig')
    WHERE last_name = 'Seo';
    
--Question 10
DELETE FROM consultants c 
    WHERE (c.first_name, c.last_name) IN (SELECT e.first_name, e.last_name 
                                                from consultants c JOIN employees e 
                                                ON c.first_name = e.first_name);
                                                
--Question 11
UPDATE regions
    SET region_name = 'North America'
       WHERE region_id = 2;
UPDATE regions
    SET region_name = 'Middle East'
       WHERE region_id = 4;

--Question 12
INSERT INTO regions(region_id, region_name)
            values(5, 'South America');
INSERT INTO regions(region_id, region_name)
            values(6, 'Africa');
            commit;
            
--Question 13
SELECT NVL(s.sales_rep_id,0) AS sales_rep , e.first_name, e.last_name, NVL(max(s.sales_AMT), 0) AS biggest_sales, s.sales_timestamp , NVL(c.cust_id, 0) AS cust_id , NVL(c.cust_fname, 0) AS cust_fname
    FROM employees e FULL OUTER JOIN customers c
    ON e.employee_id = c.cust_id
    FULL OUTER JOIN SALES s
    ON s.sales_cust_id = c.cust_id
    GROUP BY e.first_name, e.last_name, s.sales_rep_id, c.cust_id, c.cust_fname, s.sales_timestamp
    ORDER BY s.sales_rep_id;

--Question 14
SELECT e.first_name, e.last_name, e.commission_pct, (salary + e.commission_pct) AS total_pay
    FROM employees e FULL OUTER JOIN sales s 
        ON e.employee_id = s.sales_rep_id
        ORDER BY total_pay;

--Question 15
SELECT m.employee_id AS manager_employee_id, m.last_name AS managers_last_name, NVL(m.salary + (e.commission_pct), 0) AS total_compensation
FROM employees e JOIN employees m
ON e.department_id = m.department_id
FULL OUTER JOIN sales s
ON e.employee_id = s.sales_cust_id
WHERE e.employee_id = m.manager_id
--GROUP BY m.employee_id, m.last_name
ORDER BY m.employee_id;

--Question 16
SELECT DISTINCT (e.last_name), m.last_name AS manager_last_name, c.cust_fname AS custmer_first_name, c.cust_lname AS customer_last_name, c.cust_city
FROM employees e JOIN employees m
ON e.department_id = m.department_id
FULL OUTER JOIN customers c
ON e.employee_id = c.cust_id
WHERE e.employee_id = m.manager_id
ORDER BY e.last_name;
