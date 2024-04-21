-- Display the Department id, name and id and the name of its manager.
select Dnum, Dname, SSN , Fname
from Departments D inner join Employee E
on D.MGRSSN = E.SSN

-- Display the name of the departments and the name of the projects under its control.
select Dname , Pname
from Departments D inner join Project P
on D.Dnum = P.Dnum

/* Display the full data about all the dependence associated with 
the name of the employee they depend on him/her. */
select D.* , Fname
from Dependent D right outer join Employee E
on E.SSN = D.ESSN

-- Display the Id, name and location of the projects in Cairo or Alex city.
select Pnumber , Pname , Plocation 
from Project
-- where City = 'Cairo' or City = 'Alex'
where City  in ('Cairo' , 'Alex')

-- Display the Projects full data of the projects with a name starts with "a" letter.
select *
from Project
where Pname like 'a%'

-- display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
Select *
from Employee E
where Dno = 30 and Salary between 1000 and 2000

/* Retrieve the names of all employees in department 10 who works more than or 
equal10 hours per week on "AL Rabwah" project. */
select Fname 
From Employee E inner join Works_for W
on E.SSN = W.ESSn and Dno = 10 and Hours >= 10
inner join Project P
on P.Pnumber = W.Pno and Pname = 'AL Rabwah'

-- Find the names of the employees who directly supervised with Kamel Mohamed
Select Y.Fname 
from Employee X , Employee Y
where Y.Superssn = x.SSN and X.Fname = 'Kamel'

/* Retrieve the names of all employees and the names of the 
projects they are working on, sorted by the project name. */
Select Fname , Pname
from Employee E inner join Works_for W
on E.SSN = W.ESSn
inner join Project P
on P.Pnumber = W.Pno
order by Pname

/* For each project located in Cairo City , find the project number, the controlling department name ,
the department manager last name ,address and birthdate. */
select Pnumber , Dname , Lname , Address , Bdate
from Project P inner join Departments D
on D.Dnum = P.Dnum and City = 'Cairo'
inner join Employee E
on D.Dnum = E.Dno

-- Display All Data of the mangers
Select E.*
from Employee E right outer join Departments D
on E.SSN = D.MGRSSN

-- Display All Employees data and the data of their dependents even if they have no dependents
Select E.* , D.*
from Employee E full outer join Dependent D
on E.SSN = D.ESSN

/* Insert your personal data to the employee table as a new employee in department number 30,
SSN = 102672, Superssn = 112233, salary=3000. */
Insert into Employee
Values('Mamdouh' , 'Hisham' , 102672 , 28-11-2003 , 'Mansoura' , 'M' , 3000 , 112233, 30)

/*Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, 
but don’t enter any value for salary or manager number to him.*/
insert into Employee(Fname,Lname,SSN,BDATE,Address,Sex,Dno) 
values('Hazim','Ahmed',102660, 11-14-1980 ,'Alex','M',30)

-- Upgrade your salary by 20 % of its last value.
update Employee 
set Salary = Salary + Salary * 20 / 100 
where SSN=102672