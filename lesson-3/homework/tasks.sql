/*task1*/
CREATE SCHEMA Lesson_3
go
drop table if exists [Lesson_3].[Employees]
CREATE TABLE [Lesson_3].[Employees] (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

INSERT INTO [Lesson_3].[Employees] (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
(1, 'John', 'Doe', 'Marketing', 55000.00, '2021-01-15'),
(2, 'Jane', 'Smith', 'Sales', 62000.00, '2019-05-23'),
(3, 'Mark', 'Johnson', 'IT', 75000.00, '2018-07-10'),
(4, 'Emily', 'Davis', 'HR', 48000.00, '2020-11-01'),
(5, 'Chris', 'Brown', 'Finance', 80000.00, '2017-03-22'),
(6, 'Sarah', 'Wilson', 'Sales', 59000.00, '2022-06-30'),
(7, 'James', 'Miller', 'Marketing', 60000.00, '2021-09-12'),
(8, 'Patricia', 'Taylor', 'IT', 72000.00, '2019-02-15'),
(9, 'David', 'Anderson', 'Finance', 85000.00, '2020-10-05'),
(10, 'Linda', 'Thomas', 'HR', 52000.00, '2021-04-27'),
(11, 'Michael', 'Jackson', 'Marketing', 65000.00, '2018-09-17'),
(12, 'Barbara', 'White', 'Sales', 61000.00, '2019-01-05'),
(13, 'Daniel', 'Harris', 'IT', 77000.00, '2020-03-11'),
(14, 'Elizabeth', 'Martin', 'HR', 53000.00, '2021-07-19'),
(15, 'Robert', 'Lee', 'Finance', 90000.00, '2017-06-14'),
(16, 'Jennifer', 'Young', 'Sales', 65000.00, '2022-04-02'),
(17, 'William', 'King', 'Marketing', 68000.00, '2019-08-29'),
(18, 'Jessica', 'Scott', 'IT', 71000.00, '2018-04-18'),
(19, 'Charles', 'Adams', 'HR', 55000.00, '2020-12-10'),
(20, 'Mary', 'Baker', 'Finance', 83000.00, '2019-11-22');

select * from Lesson_3.Employees
/*PART1*/

SELECT TOP 10 percent * --selecting top 10 percent
FROM Lesson_3.Employees
ORDER BY Salary desc --ordering in descending order

/*part2*/

SELECT Department, AVG(SALARY)  as Average_Salary  --finding average salary
FROM Lesson_3.Employees
GROUP BY Department --grouping by department

/*part3*/

SELECT Salary, --selecting Salary column 
	CASE 
		WHEN Salary > 80000 then 'High' 
		WHEN Salary between 50000 and 80000 THEN 'Medium' --giving conditions and results
		WHEN Salary<50000 THEN 'Low'
		WHEN Salary IS Null then 'Not Provided' --in case of salary is Null
	END AS 'Salary_Category' --giving column name
FROM Lesson_3.Employees

/*part4*/


SELECT Department, AVG(SALARY)  as Average_Salary  --finding average salary
FROM Lesson_3.Employees
GROUP BY Department
order by Average_Salary desc --ordering in descending order

/*part5*/

select * from Lesson_3.Employees
order by EmployeeID --ORDERING FIRST BY eMPLOYEEid
OFFSET 2 ROWS --SKIPPING FIRST 2 ROWS
FETCH NEXT 5 ROWS ONLY --SHOWING NEXT 5 ROWS


/*TASK2*/

DROP TABLE IF EXISTS [Lesson_3].[Orders]
CREATE TABLE [Lesson_3].[Orders] (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    [Status] VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);


INSERT INTO [Lesson_3].[Orders] (OrderID, CustomerName, OrderDate, TotalAmount, [Status])
VALUES
(1, 'John Doe', '2024-01-15', 750.75, 'Shipped'),
(2, 'Jane Smith', '2024-02-23', 220.50, 'Pending'),
(3, 'Mark Johnson', '2024-03-01', 310.00, 'Delivered'),
(4, 'Emily Davis', '2024-03-10', 120.30, 'Cancelled'),
(5, 'Chris Brown', '2024-04-05', 500.00, 'Shipped'),
(6, 'Sarah Wilson', '2023-12-20', 80.00, 'Pending'),
(7, 'James Miller', '2024-01-20', 640.99, 'Shipped'),
(8, 'Patricia Taylor', '2023-11-15', 450.75, 'Delivered'),
(9, 'David Anderson', '2023-10-05', 130.60, 'Cancelled'),
(10, 'Linda Thomas', '2024-04-01', 600.40, 'Pending'),
(11, 'Michael Jackson', '2023-09-20', 850.00, 'Shipped'),
(12, 'Barbara White', '2023-08-28', 175.25, 'Delivered'),
(13, 'Daniel Harris', '2024-02-10', 210.00, 'Pending'),
(14, 'Elizabeth Martin', '2023-07-05', 320.80, 'Shipped'),
(15, 'Robert Lee', '2024-03-15', 420.50, 'Delivered'),
(16, 'Jennifer Young', '2023-06-25', 300.00, 'Cancelled'),
(17, 'William King', '2024-03-30', 1650.00, 'Shipped'),
(18, 'Jessica Scott', '2023-05-07', 550.10, 'Delivered'),
(19, 'Charles Adams', '2023-04-12', 130.00, 'Pending'),
(20, 'Mary Baker', '2024-04-12', 400.60, 'Shipped');

select *from [Lesson_3].[Orders]

/*part1*/

select CustomerName --displaying names
from [Lesson_3].[Orders]
where OrderDate between '2023-01-01' and '2023-12-31' --giving condition


/*part2*/

select*, 
	case 
		when [Status]='Shipped' or [Status]='Delivered' then 'Completed'
		when [Status]='Pending' then 'Pending' --GIVING CONDITIONS AND FINAL RESULT
		when [Status]='Cancelled' then 'Cancelled'
		when [Status] is Null then 'Not provided' --IN CASE OF STATUS IS NOT PROVIDED
	end AS OrderStatus --GIVING COLUMNNAME
from [Lesson_3].[Orders]

/*PART3*/
 
SELECT  
	case 
		when [Status]='Shipped' or [Status]='Delivered' then 'Completed'
		when [Status]='Pending' then 'Pending' --GIVING CONDITIONS AND FINAL RESULT
		when [Status]='Cancelled' then 'Cancelled'
		when [Status] is Null then 'Not provided' --IN CASE OF STATUS IS NOT PROVIDED
	end as OrderStatus,
	Count(OrderID) as TotalSales,
	sum(TotalAmount) as TotalRevenue
from [Lesson_3].[Orders]
group by 
	case
		when [Status]='Shipped' or [Status]='Delivered' then 'Completed'
		when [Status]='Pending' then 'Pending' --GIVING CONDITIONS AND FINAL RESULT
		when [Status]='Cancelled' then 'Cancelled'
		when [Status] is Null then 'Not provided' --IN CASE OF STATUS IS NOT PROVIDED
	end
order by TotalRevenue desc;

/*part4&5*/

SELECT 
    CASE 
        WHEN [Status] IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN [Status] = 'Pending' THEN 'Pending'
        WHEN [Status] = 'Cancelled' THEN 'Cancelled'
        WHEN [Status] IS NULL THEN 'Not provided'
    END AS OrderStatus,
    COUNT(OrderID) AS TotalSales,
    SUM(TotalAmount) AS TotalRevenue
FROM [Lesson_3].[Orders]
GROUP BY 
    CASE 
        WHEN [Status] IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN [Status] = 'Pending' THEN 'Pending'
        WHEN [Status] = 'Cancelled' THEN 'Cancelled'
        WHEN [Status] IS NULL THEN 'Not provided'
    END
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;




/*task3*/


CREATE TABLE [Lesson_3].[Products] (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO [Lesson_3].[Products](ProductID, ProductName, Category, Price, Stock) VALUES
(1, 'Wireless Mouse', 'Electronics', 25.99, 15),
(2, 'Bluetooth Speaker', 'Electronics', 89.99, 0),
(3, 'Laptop', 'Electronics', 999.99, 5),
(4, 'Desk Lamp', 'Furniture', 49.50, 12),
(5, 'Office Chair', 'Furniture', 199.99, 0),
(6, 'Notebook', 'Stationery', 2.99, 25),
(7, 'Pen Set', 'Stationery', 4.99, 3),
(8, 'Monitor 24"', 'Electronics', 149.99, 8),
(9, 'Standing Desk', 'Furniture', 299.99, 1),
(10, 'Ruler 30cm', 'Stationery', 1.49, 0),
(11, 'Mechanical Keyboard', 'Electronics', 129.99, 6),
(12, 'Pencil Case', 'Stationery', 6.49, 20),
(13, 'Bookshelf', 'Furniture', 99.99, 2),
(14, 'Smartphone', 'Electronics', 699.00, 10),
(15, 'Stapler', 'Stationery', 3.49, 4),
(16, 'Tablet', 'Electronics', 459.50, 0),
(17, 'File Cabinet', 'Furniture', 149.50, 9),
(18, 'Marker Set', 'Stationery', 5.49, 7),
(19, 'Gaming Chair', 'Furniture', 249.99, 13),
(20, 'LED Strip', 'Electronics', 39.99, 11);
select * from [Lesson_3].[Products]
/*part1*/

select distinct Category from [Lesson_3].[Products]

/*part2*/

SELECT Category, max(Price) as MaxPrice --finding max price
from [Lesson_3].[Products]
group by Category --grouping by category

/*part3*/

select *, Stock,
	IIF(Stock=0, 'Out of Stock', 
		iif(stock between 1 and 10, 'Low Stock','In stock')
		) as Inventory_status
from [Lesson_3].[Products]

/*part4*/
DECLARE @TotalRows INT;
SELECT @TotalRows = COUNT(*) FROM [Lesson_3].[Products];
select * 
from [Lesson_3].[Products]
order by Price DESC
OFFSET 5 ROWS
FETCH NEXT (@totalRows-5) ROWS ONLY;
