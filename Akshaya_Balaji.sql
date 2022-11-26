/*1.	Show details of the highest paid employee. Display their first and last name, salary, 
job id, department name, city, and country name. Do not hard code any values in the WHERE clause.  */

SELECT first_name AS "First name of highest paid employee", last_name AS "Last name of highest paid employee", salary, job_id, department_name, city, country_name
    FROM employees JOIN departments
        USING(department_id)
            JOIN locations
                USING(location_id)
                    JOIN countries 
                        USING(country_id)
                            WHERE salary = (SELECT MAX(salary)
                                                FROM employees);
                                                
                            
/*2.	Show any employee who still appears as a consultant. Display the first and last name, 
job id, salary, and manager id, all from the employees table. Sort the result by last name.*/

SELECT first_name, last_name, job_id, salary, manager_id
    FROM employees  
            WHERE (first_name, last_name) IN (SELECT first_name, last_name
                                                            FROM consultants)                                                           
                ORDER BY 2;
                
                
/*3.	For each customer, display their id, first name, last name, city, and their largest sale, 
total sales, largest sale as a percentage of total sales, average sales amount, and a count of 
how many sales they have each transacted. If they have no sales, show 0 for the aggregated amounts.
Sort the result by the customer's id number.*/

SELECT
    cust_id AS customer_id,
    cust_fname AS customer_firstname,
    cust_lname AS customer_lasttname,
    cust_city AS city,
    nvl(calculations.largest_sale, 0)                         AS largest_sale,
    nvl(calculations.total_sales, 0)                          AS total_sales,
    nvl(calculations.percentage_of_largest_to_total_sales, 0) AS percentage_of_largest_to_total_sales,
    nvl(calculations.average_sale, 0)                         AS average_sales,
    nvl(calculations.number_of_sales, 0)                      AS number_of_sales
FROM
    customers c
    LEFT OUTER JOIN (
        SELECT
            sales_cust_id,
            MAX(sales_amt) AS largest_sale,
            SUM(sales_amt) AS total_sales,
            round(((MAX(sales_amt)) /(SUM(sales_amt)) * 100),2) AS percentage_of_largest_to_total_sales,
            round(AVG(sales_amt),2) AS average_sale,
            COUNT(sales_cust_id) AS number_of_sales
        FROM
            sales
        GROUP BY
            sales_cust_id
    )         calculations ON c.cust_id = calculations.sales_cust_id
ORDER BY
    cust_id;
    
                    
/*4.	Show the managers who manage entire departments. Display the first and last names, department names, 
addresses, cities, and states. Sort the output by department id.*/
                    
SELECT first_name AS manger_firstname, last_name AS manger_lastname, department_name, street_address, city, state_province
	FROM departments dep 
		JOIN employees emp 
			ON (dep.manager_id = emp.employee_id) 
				JOIN locations loc
                    USING (location_id)
    ORDER BY dep.department_id;
                            
                    
/*5.	Show any employee who earns the same or more salary as her/his manager. Show the first name, last name, job id,
and salary of the employee, and the first name, last name, job id, and salary of the manager. Use meaningful column aliases throughout.*/

SELECT e.first_name AS employee_firstname, e.last_name AS employee_lastname, e.job_id AS employee_jobid, e.salary AS employee_salary,
m.first_name AS manager_firstname, m.last_name AS manager_lastname, m.job_id AS manager_jobid, m.salary AS manager_salary
    FROM employees e JOIN employees m 
        ON e.manager_id = m.employee_id
            WHERE e.salary >= m.salary ;
            
        
/*6.	Find any employee who is now at the same job they had in the past. That is, they performed a job, moved on to another job,
and are now back at their original job. Show employee id, first name, last name, job id, and salary.*/

SELECT employee_id, first_name, last_name, job_id, salary
    FROM employees e
        WHERE job_id IN (SELECT job_id
                            FROM job_history
                                WHERE employee_id = e.employee_id);


/*7.	 Show any employee who is not a manager, but earns more than any manager in the employees table. Show first name, last name,
job id, and salary. Sort the result by salary.*/
                                     
 SELECT e.employee_id, e.first_name, e.last_name, e.job_id, e.salary
    FROM employees e JOIN employees m
        ON e.manager_id = m.employee_id
            WHERE e.employee_id NOT IN (SELECT manager_id
                                            FROM employees
                                                WHERE manager_id IS NOT NULL )
               AND e.salary > ANY (SELECT man.salary
                                        FROM employees emp JOIN employees man
                                            ON man.employee_id = emp.manager_id)    
                    ORDER BY e.salary;                              
                    
/*8.	For every geographic region, provide a count of the employees in that region. Display region name, and the count. 
Be sure to include all employees, even if they have not been assigned a department. Sort the result by region name.*/  
        
SELECT NVL(region_name,'Employee not assigned to any department') AS "Region Name", COUNT(employee_id) AS "Number of employees"
    FROM regions JOIN countries
        USING (region_id)
            JOIN locations
                USING (country_id)
                    JOIN departments 
                         USING (location_id)
                            RIGHT OUTER JOIN employees 
                                 USING(department_id)
    WHERE department_id IS NOT NULL 
        OR department_id IS NULL
            GROUP BY region_name
                ORDER BY region_name;               
                                        

/*9.	PART 1: Update Kimberely Grant so that her department matches that of the other sales representatives. 
In the same update statement, change her first name to Kimberly.
PART 2: Employees Stiles and Seo are going to be earning the same pay as employee Ladwig. 
Write an update statement to change both salaries in one statement, but do not hard-code the new amount. Instead, use a subquery.*/    

UPDATE employees
    SET department_id = (SELECT DISTINCT department_id
                            FROM employees
                                WHERE job_id = 'SA_REP' AND department_id IS NOT NULL),
    first_name = 'Kimberly'                            
    WHERE last_name = 'Grant' AND job_id = 'SA_REP';


UPDATE employees 
    SET salary = (SELECT salary
                    FROM employees
                        WHERE last_name='Ladwig')
    WHERE last_name IN ('Stiles','Seo');

COMMIT; 
    
/*10.	Remove any consultants who are now full-time employees with one delete statement. Do not hard-code any values.*/ 
DELETE FROM employees
    WHERE (first_name, last_name) IN (SELECT first_name, last_name
                                        FROM consultants);
                                        

/*11.	The regions are expanding. Americas will now be called North America, and Middle East and Africa will now be called Middle East.
Write the update statements to change these regions.*/
UPDATE regions
    SET region_name =   CASE region_name
                        WHEN 'Americas' THEN 'North America'
                        WHEN 'Middle East and Africa' THEN 'Middle East'
                        ELSE region_name
                        END
    WHERE region_name IN ('Americas', 'Middle East and Africa');  
    
COMMIT;    
    
/*12.	Add a new row for South America to the Regions table. Add another row for Africa. */    
INSERT into regions(region_id, region_name)
    VALUES (5, 'South America');

INSERT into regions(region_id, region_name)
    VALUES (6, 'Africa');
    
COMMIT;
    

/*13.	For each sales representative, show their biggest sale. Display the sales representative's id, first and last names,
their largest sales amount, the timestamp of the sale, the customer id, and  customer last name. Sort the result by the sales rep's id number. */

SELECT sal.sales_rep_id, first_name, last_name,sales_calculations.largest_sale,sales_timestamp, cust_id AS customer_id, cust_lname AS customer_lastname
    FROM employees emp INNER JOIN sales sal
        ON emp.employee_id = sal.sales_rep_id
            JOIN (SELECT sales_rep_id, MAX(sales_amt) AS largest_sale
                        FROM sales
                            GROUP BY sales_rep_id) sales_calculations
             ON sal.sales_rep_id = sales_calculations.sales_rep_id 
               JOIN customers cus
                    ON sal.sales_cust_id = cus.cust_id
        WHERE sales_amt = sales_calculations.largest_sale
            ORDER BY 1;
            
/*14.	Show the commissioned employees whose total pay is above the average total pay of commissioned employees. Total pay is salary added 
to the product of commission percent multiplied by the total sales for that salesperson. Show first name, last name, and total pay. Sort the result by the total pay. */  

WITH a AS (SELECT sales_rep_id, COUNT(sales_rep_id) AS no_of_sales
                FROM sales
                    GROUP BY sales_rep_id),
     b AS (SELECT first_name, last_name, NVL2(commission_pct, salary + (no_of_sales * commission_pct), 0) AS total_pay
                FROM a JOIN employees emp
                    ON a.sales_rep_id = emp.employee_id),
     c AS (SELECT AVG(total_pay) AS average_total_pay
                FROM b)                
SELECT first_name AS "First Name of Commissioned employee", last_name AS "Last Name of Commissioned employee", total_pay
    FROM b
        WHERE total_pay > ( SELECT average_total_pay
                            FROM c)
           ORDER BY 3;  
                    
    
/*15.	Sales managers earn a commission on the total sales of all their sales representatives.
For each sales manager, calculate their total compensation, which is the manager's salary added to the 
product of the manager's commission percent multiplied by the total sales of the manager's sales representatives. 
Show the manager's employee id, the manager's last name, and their total compensation. Sort by the managers’ employee id number. */

WITH a AS (SELECT manager_id, COUNT(sales_rep_id) AS no_of_sales
            FROM sales s JOIN employees e
                ON s.sales_rep_id = e.employee_id
                    GROUP BY manager_id),
     b AS (SELECT a.manager_id AS manager_id, emp.last_name AS manager_lastname, NVL2(commission_pct, salary + (no_of_sales * commission_pct), 0) AS manager_total_compensation
            FROM a JOIN employees emp
                ON a.manager_id = emp.employee_id)
SELECT manager_id, manager_lastname, manager_total_compensation
    FROM b
        ORDER BY 1;

/*16.	For every customer’s biggest sales amount, show the sales representative’s last name, his or her manager’s last name,
the customer’s first and last names, customer’s city and country, and the amount of their largest sale. Sort by the salesperson’s last name.*/

SELECT e.last_name AS sales_rep_lastname, m.last_name AS manager_lastname,c.cust_fname AS customer_firstname, c.cust_lname AS customer_lastname,
c.cust_city AS customer_city, c.cust_country AS customer_country, sales_calculations.biggest_sale AS customers_largest_sale
    FROM employees e JOIN employees m
        ON e.manager_id = m.employee_id
            JOIN sales s
                ON e.employee_id = s.sales_rep_id
                     RIGHT OUTER JOIN (SELECT sales_cust_id,MAX(sales_amt) AS biggest_sale
                                        FROM sales
                                         GROUP BY sales_cust_id)sales_calculations
                         ON s.sales_cust_id = sales_calculations.sales_cust_id
                             JOIN customers c
                                 ON sales_calculations.sales_cust_id = c.cust_id
    WHERE sales_amt = sales_calculations.biggest_sale                            
        ORDER BY 1;
        
    