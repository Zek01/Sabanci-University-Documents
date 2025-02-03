#Find the salary of every employee
SELECT salary,fname,lname from employee;
#Find the names of the employees whose address is in Houistin and Texas
SELECT fname,lname,address FROM employee
where address LIKE "%Houistin,% TX";

#Find all data for employees in department number 5 whose salary between 30000 and 40000
SELECT * from EMPLOYEE
WHERE SALARY BETWEEN 30000 AND 40000 
AND dno=5;
# Same Result
SELECT * from EMPLOYEE
WHERE SALARY >= 30000 AND SALARY >= 40000 
AND dno=5;

# Find the salaries of all employees the maximum minimum and average salary 
SELECT sum(salary) as SUMSALARY, avg(salary) as AVGSALARY 
from employee;
# You cannot include both aggreagete and non aggregate columns within same query

#Find SSN of all employees who work on project 1,2 or 3.
Select ESSN,PNO 
FROM Works_on
WHERE pno=1 or pno= 2 or pno=3;

# OR same for do not want repetations use distinct

Select distinct ESSN,PNO 
FROM Works_on
WHERE pno in (1,2,3);

# Find the names of employees who does not have superviser

Select fname,lname,superssn
From employee
Where superssn is NULL;
