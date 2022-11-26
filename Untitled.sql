/* 9) Show the characters in the street address in the locations table beginning
      with the character after the first space. For example, if the address is 
      10 Downing Street, just show Downing Street. Label the column street.*/
      SELECT concat(last_name, ',', salary, ',', '$', TO_CHAR(salary * 3)) AS Dream_Salaries
           FROM employees;