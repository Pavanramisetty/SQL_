/*16.	For every customerís biggest sales amount, show the sales representativeís last name, 
his or her managerís last name, the customerís first and last names, customerís city and country, 
and the amount of their largest sale. Sort by the salespersonís last name. */

SELECT MAX(sales_amt) maximum_sales_amount, e.last_name,(SELECT last_name FROM employees WHERE employee_id = e.manager_id) as manager,
c.cust_fname,c.cust_lname,c.cust_city,c.cust_country
FROM employees e JOIN sales s
ON e.employee_id = s.sales_rep_id 
JOIN customers c
ON s.sales_cust_id = c.cust_id
GROUP BY e.last_name,e.manager_id,c.cust_fname,c.cust_lname,c.cust_city,c.cust_country
HAVING MAX(sales_amt) in (select max(sales_amt) from sales group by sales_cust_id)
ORDER BY e.last_name;