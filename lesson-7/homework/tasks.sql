use Lesson_7

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);


--VALUES
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Carlos Martinez'),
(4, 'Diana Prince'),
(5, 'Ethan Brown'),
(6, 'Fiona Davis');

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(201, 1, '2024-05-01'),
(202, 2, '2024-05-02'),
(203, 3, '2024-05-03'),
(204, 4, '2024-05-04'),
(205, 1, '2024-05-05');

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(301, 201, 101, 1, 1200.00),
(302, 201, 105, 3, 3.50),
(303, 202, 102, 2, 150.00),
(304, 203, 103, 5, 2.00),
(305, 204, 104, 1, 800.00),
(306, 205, 106, 1, 250.00),
(307, 205, 101, 1, 1150.00);

INSERT INTO Products (ProductID, ProductName, Category) VALUES
(101, 'Laptop', 'Electronics'),
(102, 'Desk Chair', 'Furniture'),
(103, 'Notebook', 'Stationery'),
(104, 'Smartphone', 'Electronics'),
(105, 'Pen Set', 'Stationery'),
(106, 'Bookshelf', 'Furniture');


--==============================================================
--TASKS

--task1

select *
from Customers c
left join Orders o
on c.CustomerID=o.CustomerID

-- task2
select c.CustomerName
from Customers c
left join Orders o
on c.CustomerID=o.CustomerID
where o.orderID is null;

--task3

select 
o.OrderID, p.ProductName, d.Quantity
from OrderDetails d
left join Orders o
on d.OrderID=o.OrderID
left join Products p
on d.ProductID=p.ProductID

--task4

select c.CustomerName
from Customers c
join Orders o 
on c.CustomerID=o.CustomerID
group by c.CustomerName
having count(o.OrderID)>1;

--task5

SELECT o.OrderID, c.CustomerName, p.ProductName, d.Price
FROM OrderDetails d
JOIN Products p ON d.ProductID = p.ProductID
JOIN Orders o ON d.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE d.Price=(
	select max(d2.Price)
	from OrderDetails d2
	where d2.OrderID=d.OrderID
);


--task6

select c.CustomerName, o.OrderID as LatestOrderID, o.OrderDate as LatestOrderDate
from Orders o
join (
	select CustomerID, max(OrderDate) as LatestOrder
	from Orders
	group by CustomerID
) l on o.CustomerID=l.CustomerID
join Customers c
on o.CustomerID=c.CustomerID;

--task7

select distinct c.CustomerName

from Customers c
join Orders o
on c.CustomerID=o.CustomerID
join OrderDetails d
on o.OrderID=d.OrderID
join Products p
on d.ProductID=p.ProductID
where p.Category='Electronics'


except --to cut the ones to display only electronics


select distinct c.CustomerName
from Customers c
join Orders o
on c.CustomerID=o.CustomerID
join OrderDetails d
on o.OrderID=d.OrderID
join Products p
on d.ProductID=p.ProductID
where p.Category<>'Electronics'




--task8

select c.CustomerName 
from Customers c
join Orders o
on c.CustomerID=o.CustomerID
join OrderDetails d
on o.OrderID=d.OrderID
join Products p
on d.ProductID=p.ProductID
where p.Category='Stationery' 
group by c.CustomerName
having count(*)>=1;


--task9

select c.CustomerID, c.CustomerName, 
	sum(d.Price*d.Quantity) as TotalCost

from Customers c
join Orders o
on c.CustomerID=o.CustomerID
join OrderDetails d
on o.orderID=d.OrderID
group by c.CustomerID, c.CustomerName;