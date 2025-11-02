create table employees(
 empId int primary key,
  --empName varchar(50),
  --empDepat varchar(50),
  --salary decimal(10,2),
--city varchar(50)
--);
/*INSERT INTO Employees (empId, empName, empDepat, salary, city) VALUES
(1, 'Roshan', 'IT', 51444, 'Pune'),
(2, 'Sneha', 'HR', 51823, 'Mumbai'),
(3, 'Aarav', 'Finance', 51267, 'Delhi'),
(4, 'Priya', 'Marketing', 51932, 'Bangalore'),
(5, 'Rohan', 'IT', 52345, 'Chennai'),
(6, 'Neha', 'Sales', 51789, 'Hyderabad'),
(7, 'Karan', 'Operations', 52011, 'Kolkata'),
(8, 'Meera', 'HR', 51678, 'Ahmedabad'),
(9, 'Aditya', 'IT', 52490, 'Jaipur'),
(10, 'Kavya', 'Finance', 52135, 'Chandigarh');

*/

--select count(*) as totalworker
--from Employees;

-- select sum(salary) as totalsalary
-- from Employees;
--select max(salary) as maxSalary
--from Employees;

--select avg(salary) as avgSalary
--from Employees;

--select min(salary) as minSalary
--from Employees;
-- department wise max , min , count and avg salary
/*
select department, avg(salary) as avgSalary
from Employees
GROUP BY Department;
*/

/*
select Department, max(salary) as maxSalary
from Employees
GROUP BY Department;
*/
/*
select Department, min(salary) as minSalary
from Employees
GROUP BY Department;
*/
/*
select Department, count(*) as worker
from Employees
GROUP BY Department;
*/


/*
select Department, sum(salary) as totalsalary
from Employees
GROUP BY Department
Having sum(salary)>100000;
*/

/*
select COUNT(DISTINCT city) as uniquecities
from Employees;

select DISTINCT city 
from Employees;

select COUNT(DISTINCT Department) as uniqueDepartment
from Employees;

select DISTINCT Department
from Employees;

select max(salary) from Employees
GROUP BY Department
*/
/*
select  e.EmpID , e.EmpName, e.Department, e.Salary, e.City
from Employees e
where e.salary = (
  select max(salary)
  from Employees
where Department = e.Department
);
*/
select City, count(*) as topearnercount
from (
select  e.EmpID , e.EmpName, e.Department, e.Salary, e.City
from Employees e
where e.salary = (
  select max(salary)
  from Employees
where Department = e.Department
)
) as topearner 

GROUP BY city;

