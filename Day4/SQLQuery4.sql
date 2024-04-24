-- The name and the gender of the dependence that's gender is Female and depending on Female Employee
select Dependent_name
from Dependent 
where Sex = 'F' 
union
select Dependent_name
from Dependent as D
where D.ESSN in (select SSN from Employee where Sex = 'F')

-- For each project, list the project name and the total hours per week (for all employees) spent on that project
select Pname , Hours
from Project P inner join Works_for W
on P.Pnumber = W.Pno

-- Display the data of the department which has the smallest employee ID over all employees' ID.
Select D.* , min(MGRSSN) as Min_ID
from Departments D
group by Dname , Dnum , MGRSSN , [MGRStart Date] 

-- For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
select Dname , max(Salary) as Max_salary , min(Salary) as Min_salary, avg(Salary) as Avg_salary
from Departments D inner join Employee E
on D.Dnum = E.Dno
group by Dname

-- List the last name of all managers who have no dependents.
Select Lname
from Employee 
where SSN in (select MGRSSN
			  from Departments) and
	  SSN not in (select ESSN
					 from Dependent)


/*For each department-- if its average salary is less than the average salary of all employees-- 
display its number, name and number of its employees*/
Select Dnum , Dname , count(E.Fname) as numOfEmployees
from Departments D inner join Employee E
on D.Dnum = E.Dno
group by Dnum , Dname
having Avg(E.Salary) < (select Avg(Salary) 
						from Employee)

/*Retrieve a list of employees and the projects they are working on ordered by department and within each department, 
ordered alphabetically by last name, first name.*/
Select D.Dname , E.Fname , E.Lname , P.Pname 
from Departments D , Employee E , Works_for W , Project P
where D.Dnum = E.Dno and 
	  E.SSN = W.ESSn and 
	  W.Pno = P.Pnumber
order by D.Dname Desc, E.Lname ASC, E.Fname ASC 

-- Try to get the max 2 salaries using subquery
select Distinct Salary
from Employee E
where 2 >= 
(select Count(Distinct Salary)
			from Employee A
			where A.Salary >= E.Salary)
And E.Salary is not null

-- Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%
Update Employee
Set Salary = Salary * 30 / 100
where SSN in (Select SSN
			  From Employee E inner join Works_for W
			  on E.SSN = W.ESSn
			  inner join Project P
			  on W.Pno = P.Pnumber and Pname = 'Al Rabwah')


