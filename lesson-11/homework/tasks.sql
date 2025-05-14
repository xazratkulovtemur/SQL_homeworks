--task1

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);


CREATE TABLE #EmployeeTransfers (
	EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

insert into #EmployeeTransfers
select* from 
(
	select e1.EmployeeID as EmployeeID, e1.Name as Name,
	case
		when e1.Department='HR' then 'IT'
		when e1.Department='IT' then 'Sales'
		when e1.Department='Sales' then 'HR'
	end as Department,
	e1.Salary as Salary
	from Employees e1
	join Employees e2
	on e1.EmployeeID=e2.EmployeeID
) as table1

--checking 
select * from Employees
select * from #EmployeeTransfers


--========================================================

--tasks2
CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);

declare @MissingOrders table (
	OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
)


insert into @MissingOrders
select OrderID, CustomerName, Product, Quantity
from 
(
	select db1.OrderID, db1.CustomerName, db1.Product, db1.Quantity, db2.OrderID as iden
	from Orders_DB1 db1
	left join Orders_DB2 db2
	on db1.OrderID=db2.OrderID
	
) as table2
where iden is null
select * from @MissingOrders


--============================================
--task3
CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

create view vw_MonthlyWorkSummary as
with TotalHoursPerEmp as (
	select EmployeeID, sum(HoursWorked) as TotalperEmp
	from Worklog 
	group by EmployeeID
	
), 
joinedwithTotal as
(
	select wl.EmployeeID, wl.EmployeeName, wl.Department, wl.WorkDate, wl.HoursWorked, the.TotalperEmp
	from WorkLog wl
	join TotalHoursPerEmp the
	on wl.EmployeeID=the.EmployeeID
),
TotalHoursPerDep as (
	select Department, sum(HoursWorked) as TotalbyDep, count(*) as Num
	from Worklog
	group by Department
),
avghoursperDep as (
	select Department, TotalbyDep/Num as AvgbyDep
	from TotalHoursPerDep
),
final as (

	select jwt.EmployeeID, jwt.EmployeeName, jwt.Department,jwt.TotalperEmp, thpd.TotalbyDep, ahpd.AvgbyDep
	from joinedwithTotal jwt
	join TotalHoursPerDep thpd
	on jwt.Department=thpd.Department
	join avghoursperDep ahpd
	on jwt.Department=ahpd.Department
)
select distinct * from final


--using window
select * from vw_MonthlyWorkSummary
