DROP TABLE IF EXISTS Employees
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');


/*task1*/
select *,
	Dense_rank() OVER(ORDER BY Salary desc) as [Rank] 
from Employees         --ordering by Salary at descending order

/*task2*/
select *
from (
	select *, 
		dense_rank() over(order by Salary desc) as SalaryRank --selecting all columns, + ranks
	from Employees
	) as Ranked
where SalaryRank in ( --filtering ranks in this table
	Select SalaryRank  --and get this values
		from (
			select dense_rank() over(order by Salary desc) as SalaryRank --assigning rank
			from Employees
			)as Ranks
			group by SalaryRank --grouping by these ranks
			having count(*)>1 --checking if there are more than 2 columns,
);


/*task3*/

select * from (
	select *,
	ROW_NUMBER() over(partition by Department order by Salary desc) as Rank --assigning rank 
	from Employees
) as MyTable
where Rank=1 or Rank=2 --filtering where rank is 1 or 2

/*task4*/

select * from (
	select *,
	ROW_NUMBER() over(partition by Department order by Salary asc) as Rank --assigning rank in ascending order
	from Employees
) as MyTable
where Rank=1 --finding first and lowest salary

/*task5*/

select *,
	sum(Salary) over(partition by Department order by Salary) as Sum --cumulative sum
from Employees

/*task6*/
select Department, TotalSalary from 
(
select *,
	sum(Salary) over (partition by Department) as TotalSalary, --finding total sum
	row_number() over (partition by Department order by EmployeeID) as rownum --giving rownum
from Employees) as Mytable
where rownum=1; --in order to display departments once, i use this method

/*task7*/
select Department,
	TotalSalary/Number as AverageSalary --finding average salary
	from (select *,
		sum(Salary) over (partition by Department) as TotalSalary, --finding sum
		count(Salary) over (partition by Department) as Number, --numebr of employees
		row_number() over (partition by Department order by EmployeeID) as rownum 
	from Employees) as MyTable
where rownum=1; --in order to display departments once, i use this method


/*task8*/
select Department, 	totalsalary/number as AverageSalary,
	Salary - totalsalary/number as DifferenceinSalary
	from 
	(
		select *,
		sum(Salary) over(partition by Department) as totalsalary,
		count(salary) over (partition by Department) as number
		from Employees
	) as Mytable


/*task9*/

select *, 
	Sumof3employees/3 as Averageof3 --finding averageof 3 employee
	from (
		select*, 
			sum(Salary) over(order by EmployeeID rows between 1 preceding and 1 following) as Sumof3employees --finding sumoof 3 employees
			from Employees
	) as Mytable;

/*task10*/

select  
	Max(sumoflast3) as last3sum --since this query find cumulative sum, i find max of them that is final answer
from 
	(
		select*,
		sum(Salary) over(order by HireDate desc) as sumoflast3,
		row_number() over(order by HireDate desc) as rownum
		from Employees
	) as Mytable
where rownum between 1 and 3;


/*task11*/

select *, 
	sumofprev/number as running_avg_salary --find average salary
from 
	(
		select *,
		sum(Salary) over(order by EmployeeID rows between unbounded preceding and current row) as sumofprev,--finding sum of salary of previous of current row
		count(Salary) over(order by EmployeeID rows between unbounded preceding and current row) as number --finding number of employees
		from Employees
	) as mytable;

/*task12*/
select *
from 
	(
		select *,
		Max(Salary) over(order by EmployeeID rows between 2 preceding and 2 following) as MaxSalary  --finding max salary between 2 preceding and 2 following
		from Employees
	) as Mytable;

/*task13*/

select *, 
	CAST(Salary / sum(Salary) over() *100 AS DECIMAL(10,2)) AS PORTION --converting to decimal to cut integers after ,
from Employees








