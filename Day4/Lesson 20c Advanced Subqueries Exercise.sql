/*Look through Lesson 20b Advanced Subqueries.sql and run the code examples there, 
then practice advanced subqueries with the excercises below:
*/
--Practice advanced subqueries

/* 1) Show those employees who earn the lowest salary in their department, using  
      a correlated subquery. Display the employee number, first and last names, 
      their job, salary, manager name and department name. Use a correlated subquery
      to retrieve the lowest salary for the employee's department.
      Sort the result by salary. */
  
 


/* 2) Show the above result using using pairwise comparison, instead of a correlated
      subquery.
      
      


/* 3) Use the EXISTS operator to show the departments in the departments table
      that are found in the employees table. Show the department number and name. */
  
  




--4) Now use a plain, non-correlated subquery to do the same.
    



/* 5) Use NOT EXISTS to show those employees who do not have a previous
      job with the company. Show employee number, first and last name,
      current job and salary. */
    
    


/* 6) Show any employee who is now at the same job they had in the past. That is,
      they performed a job, moved on to another job, and are now back at their
      original job. Use pairwise comparison to find the result. */
  
  
   

/*  7) Use the WITH clause to find the the total pay for each salesperson whose total pay
        is below average. Total pay is salary added to the product of total sales 
        multiplied by their commission percent. Display first and last names, 
        salary, commission_pct, and total pay. Use the column alias total_pay 
        for the last column. Sort the result by total_pay descending. */
        



                                         
/* 8) Use the WITH clause to find those managers who manage a larger than 
      average staff. Show manager's id, first and last name, 
      and the size of their staff. Remember, there is a null manager. Include 
      it in your calculations. Use an id of 999 for it. */






