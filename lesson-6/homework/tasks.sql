use Lesson_6

/*TABLES*/

-- 1. Employee_s Table

CREATE TABLE Employee_s (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    DepartmentID INT,
    Salary INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 2. Department_s Table
CREATE TABLE Department_s(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- 3. Projects Table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee_s(EmployeeID)
);

--Department_s values
INSERT INTO Department_s (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

--Employee_s values
INSERT INTO Employee_s (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);

--Projects values
INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 3),
(4, 'Delta', 4),
(5, 'Omega', NULL);



/*task1*/

select E.Name, D.DepartmentName --displaying Employee name and their department
from Employee_s as E  --
inner join Department_s as D 
on E.DepartmentID=D.DepartmentID --joining two tables with departmentID

/*task2*/

select E.Name, D.DepartmentName
from Employee_s as E
left join Department_s as D --using left join to display all employees 
on E.DepartmentID=D.DepartmentID


/*task3*/

select D.DepartmentName, string_agg(E.Name, ', ') --directing empnames to one place
from Employee_s as E
right join Department_s as D
on D.DepartmentID=E.DepartmentID
group by D.DepartmentName; --grouping by departmentname, since there might be several employees in departments. to prevent departmentnames being displayed multiple times, we group them


/*task4*/

select E.Name, D.DepartmentName
from Employee_s as E
full outer join Department_s as D --full outer join 
on E.DepartmentID=D.DepartmentID --departmentID

/*task5*/

select D.DepartmentName, 
	sum(Salary) as TotalSalaryExpense  --column name
from Department_s as D
left join Employee_s As E
on D.DepartmentID=E.DepartmentID
group by D.DepartmentName --grouping by DepartmentName

/*task6*/

select  D.DepartmentName, P.ProjectName
from Department_s as D
cross join Projects as P;

/*task7*/

select E.Name, D.DepartmentName, P.ProjectName --displaying, Name, Department, Project
from Employee_s as E
left join Department_s as D    --joining department with employees
on E.DepartmentID=D.DepartmentID
left join Projects as P --joining employees with Projects
on E.EmployeeID=P.EmployeeID 





