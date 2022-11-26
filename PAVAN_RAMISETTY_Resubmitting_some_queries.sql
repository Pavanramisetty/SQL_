--Question no 3
SELECT c.cust_id AS customer_Id, c.cust_fname AS customer_first_name, c.cust_lname AS customer_last_name, 
c.cust_city AS customer_city, NVL(max(s.sales_amt), 0) AS largest_sale, 
NVL(round(AVG(s.sales_amt), 2), 0) AS average_sales, count(s.sales_id) AS number_of_sales, 
round((max((s.sales_amt) * 100 )), 2) as percentage_of_sale, Round(Avg(s.sales_amt),2) as sales_average,count(s.sales_id) as count_of_sales
FROM customers c JOIN sales s
ON c.cust_id = s.sales_cust_id
GROUP BY c.cust_id, c.cust_fname, c.cust_lname, c.cust_city
ORDER BY cust_id;

--Question 5
SELECT e.first_name AS employee_first_name, e.last_name employee_last_name, e.job_id AS employee_job_id, e.salary AS employee_salary, 
m.first_name as manager_first_name, m.last_name AS manager_last_name, m.job_id as manager_job_id, m.salary as manager_salary
FROM employees e JOIN employees m
ON m.employee_id = e.manager_id
WHERE(e.salary >= m.salary)
ORDER BY e.first_name;

--Question 6
SELECT DISTINCT e.employee_id, e.first_name, e.last_name, e.job_id, e.salary
FROM employees e JOIN job_history j
ON e.department_id = j.department_id
WHERE e.job_id = j.job_id;

--Question 8
SELECT r.region_name, count(e.employee_id) AS employee_count
FROM regions r JOIN countries c
ON r.region_id = c.region_id
JOIN locations l
ON l.country_id = c.country_id 
JOIN departments d
ON l.location_id = d.location_id
JOIN employees e
ON e.department_id = d.department_id
WHERE d.department_id is NULL or d.department_id is NOT Null
GROUP BY r.region_name
ORDER BY region_name;

--Question 13
SELECT NVL(s.sales_rep_id,0) AS sales_rep , e.first_name, e.last_name, NVL(max(s.sales_AMT), 0) AS biggest_sales, s.sales_timestamp , NVL(c.cust_id, 0) AS cust_id , NVL(c.cust_fname, 0) AS cust_fname
FROM employees e JOIN sales s
ON e.employee_id = s.sales_rep_id
JOIN CUSTOMERS c
ON s.sales_cust_id = c.cust_id
GROUP BY e.first_name, e.last_name, s.sales_rep_id, c.cust_id, c.cust_fname, s.sales_timestamp
HAVING Max(s.sales_amt) in (SELECT Max(sales_amt) FROM sales 
	   GROUP BY sales_rep_id)
ORDER BY s.sales_rep_id;

--Question 14
WITH sales_table AS(SELECT sales_rep_id, count(sales_id) as totalSales
FROM sales 
GROUP BY sales_rep_id),
employee_table AS (SELECT first_name, last_name, NVL(salary +(totalSales * commission_pct),0) AS total_pay
FROM sales_table JOIN employees e
ON sales_table.sales_rep_id = e.employee_id),
pay_table AS (SELECT avg(total_pay) AS depts_avg
FROM employee_table)
SELECT first_name,last_name,total_pay
FROM employee_table
WHERE  total_pay > (SELECT depts_avg FROM pay_table)
ORDER BY total_pay;

--Question 15
SELECT m.employee_id, m.last_name AS employee_last_name, (m.salary + (m.commission_pct * COUNT(s.sales_rep_id))) AS total_compensation_of_employee
FROM sales s JOIN employees e
ON e.employee_id = s.sales_rep_id 
JOIN employees m
ON e.manager_id = m.employee_id
GROUP BY m.employee_id, m.last_name, m.salary, m.commission_pct
ORDER BY employee_id;

--QUESTION 16
SELECT MAX(sales_amt) maximum_sales_amount, e.last_name,(SELECT last_name FROM employees WHERE employee_id = e.manager_id) as manager,
c.cust_fname,c.cust_lname,c.cust_city,c.cust_country
FROM employees e JOIN sales s
ON e.employee_id = s.sales_rep_id 
JOIN customers c
ON s.sales_cust_id = c.cust_id
GROUP BY e.last_name,e.manager_id,c.cust_fname,c.cust_lname,c.cust_city,c.cust_country
HAVING MAX(sales_amt) in (select max(sales_amt) from sales group by sales_cust_id)
ORDER BY e.last_name;

