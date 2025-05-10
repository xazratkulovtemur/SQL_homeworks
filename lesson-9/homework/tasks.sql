CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');


--task1


;with leveltable as (
	select EmployeeID, ManagerID, JobTitle, 0 as depth
	from Employees
	where ManagerID is Null

	union all

	select e.EmployeeID, e.ManagerID, e.JobTitle, l.depth +1
	from Employees e
	join leveltable l 
	on e.ManagerID =l.EmployeeID
)

select * from leveltable

--========================================================================
--TASK 2

declare @n int  =10

;with factorialCTE as( 
	select 1 as num, 1 as factorial
	union all
	select num+1, factorial * (num+1)
	from factorialCTE
	where num<@n
)

select * from factorialCTE

--======================================================
--TASK3
DECLARE @N1 INT = 10
;WITH FIBONCTE AS(
	SELECT 0 AS N, 0 AS FIB, 1 AS NEXT_FIB
	UNION ALL
	
	SELECT N+1, NEXT_FIB AS FIB, FIB+NEXT_FIB AS NEXT_FIB
	FROM FIBONCTE
	WHERE N+1<@N1
)
SELECT N, FIB FROM FIBONCTE