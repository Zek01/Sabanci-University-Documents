use companydb;

# Q14 Find the number of employees in the 'Research' department

select count(*)
from employee,department
where dno = dnumber 
and dname =  "Research";

select fname,lname
from employee,department
where dno = dnumber 
and dname =  "Research";

# Q15 For each project retrieve project number,the project name and
#the number of employees form department 5 who work on the project
# count wants to take 1 row but pnumber and pname has more than 1 row so aggregated query group by error occur
# You should group the not aggregated ones. 
select pnumber,pname, count(ssn)
from project,works_on,employee
where dno = 5 
and pno = pnumber 
and essn = ssn
group by pnumber,pname
;

#Q16 For each project on which more than 2 employees work, retrieve the project number
# the project name  and the number of employees who work on that project 
# essn from works_on table we will find the working employees
#anything that is not aggregated should be group by
# aggregation rules should be after the group by statment not under which statement.
# If you want to filter acc to aggregated column count than you have to write under groupby with having statemnt
# If you want to filter acc to not aggreagted column write under which.
select pnumber,pname, count(essn)
from project,works_on
where pno = pnumber
group by pnumber,pname
having count(essn) > 2
;

select pnumber,pname, count(essn)
from project,works_on
where pno = pnumber
and pno > 10
group by pnumber,pname
having count(essn) > 2
;

# Q17 Find the name of the each employee who has a dependent with the same gender as the employee
# Do not give all the employees just bring the ssn that are in subquery. 
select employee.fname,employee.lname
from employee
where employee.ssn in (select essn
from dependent, employee
where employee.gender = dependent.gender)
;
select employee.fname,employee.lname
from employee,dependent
where employee.ssn = dependent.essn
and employee.gender = dependent.gender
/*
select fname,lname,gender
from employee
where lname = "Wong" or lname "Wallace" or lname = "Borg"
;

select fname,lname,gender
from employee 
where lname in ("Wong","Wallace", "Borg")
;

select e2.fname, e2.lname, e2.gender
from employee e2
where lname in (select e1.lname from employee as e1 where lname like "W%")
;
*/

#Left outer queries
# bring all employees and their dependences if there is any
select e.fname,e.lname,d.dependent_name,d.gender,e.ssn,d.essn
from employee as e left outer join dependent d
where e.ssn = d.essn
;