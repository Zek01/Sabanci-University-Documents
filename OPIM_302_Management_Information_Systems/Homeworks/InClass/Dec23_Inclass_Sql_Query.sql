use companydb;

SELECT * FROM companydb.employee;
SELECT min(salary) as MinSalary, max(salary) as MaxSalary
FROM employee;

#cartesian product
select fname,lname, dependent_name
from employee,dependent;


# Q7 Find All the employees who were born during 1960's
/*
select fname,lname,bdate
from employee
where bdate LIKE "*6?";
*/
#Include 6 before the last character before 6 it can be everything.
select fname,lname,bdate
from employee
where year(bdate) like "%6_";


# Q8 For each department retrieve the department numbers,the number of employees in the department and their average salary.
# if it is not in group by you should aggreate it.
select dno, count(lname) as NumOfEmps, avg(salary) as AvgSal
from employee
group by dno
;

#Q9 Find the name and address of all employees who work for the "Research" department
# Inner Join example:
select address, dname
from department,employee
where department.dnumber = employee.dno
and department.DNAME = "Research"
;

#with using alliases 
select address, dname
from department as d,employee as e
where d.dnumber = e.dno and d.DNAME = "Research"
;

# Q10 For every project located in "Stafford", list the project number, the controlling departments number and the department manager's last name
# project -> PLOACATION, PNUMBER, DNUM
#employee ->  LNAME
# if they have the same column names you have to specify the table come from to solve ambiguity.
select project.plocation,project.pnumber,project.dnum,employee.lname
from project,employee,department
where project.DNUM = department.dnumber 
and project.plocation = "Stafford"
and department.MGRSSN = employee.SSN
;

#Q11 For each employee, retrieve the employee's first and last name and first and last name of his or her supervisior 
# Call employee twice first time it gives fname,lname,superssn
select e1.fname as empFname,e1.lname as empLname,e1.superssn as empSuperSSN,
e2.fname as manFname,e2.lname as manLname
from employee as e1,employee as e2
where e1.superssn = e2.ssn
;


# Q12 Retrieve the list of employees and projects they are working on, ordered by the project and within each project ordered alphabatically by last name and then first name.
#bring project name
select fname,lname,pname
from employee,works_on,project
where ssn=essn 
and pno = pnumber
order by pname,lname,fname;

# Q13 Find the sum of the salaries of all employees of the "Research" department, as well as the maximum,minimum and the average salary in this department
# fname takes values more than one without group by it wont work.
select sum(salary) as totalSalary,min(salary) as mnSal,max(salary) as maxSal,avg(salary) as meanSal
from employee,department
where dno=dnumber
and dname = "Research"
;



