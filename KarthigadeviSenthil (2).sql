/*1*/
SELECT e.first_name as Employee_firstName,e.last_name  as Employee_lastName,e.salary as Salary,e.job_id as JobID,d.department_name as DepartmentName,l.city as City,c.country_name as Country
FROM employees e JOIN departments d
USING(department_id)
JOIN locations l
USING(location_id)
JOIN countries c
USING(country_id)
WHERE e.salary = (select Max(e.salary)
from employees e join employees m
on e.job_id= m.job_id);

/*2*/
SELECT e.first_name as FirstName,e.last_name as LastName,e.job_id as JobID,e.salary as Salary,e.manager_id as ManagerID
FROM employees e join consultants c
on e.first_name = c.first_name and e.last_name = c.last_name
ORDER BY 2;
                
/*3*/
SELECT c.cust_id as CustomerID,c.cust_fname as CustomerFirstName,c.cust_lname as CustomerLastName,c.cust_city as City,Max(NVL(s.sales_amt,0)) as LargestSale,count(s.sales_id)as TotalSale, (MAX(sales_amt)/100) as Percentage,
Round(Avg(s.sales_amt),2) as AverageAmount,count(s.sales_id) as SalesCount
FROM customers c join sales s
ON c.cust_id = s.sales_cust_id
GROUP BY c.cust_id,c.cust_fname,c.cust_lname,c.cust_city
ORDER BY 1;

/*4*/
SELECT e.first_name as ManagerFirstName ,e.last_name as ManagerLastName,d.department_name as DepartmentName,l.street_address as Street,l.city as City,l.state_province as State
FROM employees e JOIN departments d
ON(e.department_id = d.department_id)
JOIN locations l
ON(d.location_id= l.location_id) 
WHERE e.employee_id IN (select manager_id
from employees
group by manager_id
Having count(distinct(department_id)) >1) 
ORDER BY e.department_id;

/*5*/
select e.first_name as EmployeeFirstName,e.last_name as EmployeeLastName,e.job_id as EmployeeJobID,e.salary as EmployeeSalary,m.first_name as ManagerFirstName,m.last_name as ManagerLastName,m.job_id as ManagerJobId,m.salary as ManagerSalary
from employees e join employees m
on e.manager_id = m.employee_id
where e.salary >= m.salary ;

/*6*/
SELECT e.employee_id as EmployeeID,e.first_name as EmployeeFirstName,e.last_name as EmployeeLastName,e.job_id as JobID,e.salary as Salary
FROM employees e JOIN job_history j
ON e.job_id = j.job_id AND 2<=(select count(*) from job_history where employee_id = e.employee_id);

/*7*/
select distinct e.first_name as EmployeeFirstName,e.last_name as EmployeeLastName,e.job_id as JobID,e.salary as Salary
from employees e join employees m
on e.employee_id not in (select m.employee_id from employees e join employees m on e.employee_id = m.manager_id)
and e.salary > ANY(select m.salary from employees e join employees m on e.employee_id = m.manager_id);

/*8*/
select region_name as RegionName,count(employee_id) as TotalEmployeeID
FROM regions join countries
using(region_id)
join locations
using(country_id)
join departments
using(location_id)
join employees
using(department_id)
where department_id is null or department_id is not null
group by region_name
order by 1;

/*9*/
/*part1*/
UPDATE employees set first_name ='Kimberly',department_id = (select distinct(department_id) from employees where job_id = 'SA_REP' and department_id is not null)
where (first_name = 'Kimberely' and last_name = 'Grant');

/*part2*/
UPDATE employees set salary = (select salary from employees where last_name = 'Ladwig')
WHERE last_name in('Seo','Stiles');

/*10*/
DELETE from employees where employee_id in (select employee_id
from employees e join consultants c 
on e.first_name = c.first_name and e.last_name = c.last_name);

/*11*/
update regions set region_name = (case when(region_name = 'Americas') then 'North America'
                                       when(region_name = 'Middle East and Africa') then 'Middle East'
                                       else (region_name)
                                       end);
/*12*/                                            
insert into regions
values(5,'South America');

insert into regions
values(6,'Africa');

/*13*/
select s.sales_rep_id as SalesRepID,e.first_name as SalesRepFirstName,e.last_name as SalesRepLastName,s.sales_timestamp as TimeStamp,s.sales_cust_id as CustomerID,c.cust_lname as CustomerLastName ,Max(s.sales_amt) as MAximumSalesAmount
from sales s join employees e
on e.employee_id = s.sales_rep_id
join customers c
on c.cust_id = s.sales_cust_id
group by s.sales_rep_id,e.first_name,e.last_name,s.sales_timestamp,s.sales_cust_id,c.cust_lname
Having Max(s.sales_amt) in (select Max(sales_amt) from sales group by sales_rep_id)
order by 1;

/*14*/
WITH a AS(select sales_rep_id, count(sales_id) as totalSales
from sales 
group by sales_rep_id),
    b AS (
		SELECT first_name,last_name,NVL2(commission_pct,salary +(totalSales * commission_pct),0) AS totpay
			FROM a JOIN employees e
			ON a.sales_rep_id = e.employee_id),
	  c AS (
		SELECT avg(totpay) AS depts_avg
			FROM b)
SELECT first_name as EmployeeFirstName,last_name as EmployeeLastName,totpay as TotalPay
	FROM b
	WHERE  totpay > (SELECT depts_avg
							FROM c)
	ORDER BY 3;

/*15*/
WITH a AS(select sales_rep_id, count(sales_id) as totalSales
from sales 
where sales_rep_id in(select employee_id from employees
where manager_id in(select employee_id from employees where job_id = 'SA_MAN'))
group by sales_rep_id),
    b AS (
		SELECT manager_id,last_name,NVL2(commission_pct,salary +(totalSales * commission_pct),0) AS totComp
			FROM a JOIN employees e
			ON a.sales_rep_id = e.employee_id )   
    SELECT manager_id as ManagerID,last_name as ManagerLastName,totComp as TotalCompensation
	FROM b
	WHERE  manager_id in (SELECT employee_id from employees where job_id ='SA_MAN')
	ORDER BY 1;

/*16*/
select max(sales_amt) as MaximumSalesAmount,e.last_name as SalesRepLastName,(select last_name from employees where employee_id = e.manager_id) as ManagerName,
c.cust_fname as CustomerFirstName,c.cust_lname as CustomerLastName,c.cust_city as CustomerCity,c.cust_country as CustomerCountry
from employees e join sales s
on e.employee_id = s.sales_rep_id 
join customers c
on s.sales_cust_id = c.cust_id
group by e.last_name,e.manager_id,c.cust_fname,c.cust_lname,c.cust_city,c.cust_country
having Max(sales_amt) in (select max(sales_amt) from sales group by sales_cust_id)
order by 2;
