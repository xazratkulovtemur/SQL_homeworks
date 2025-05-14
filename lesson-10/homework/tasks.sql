CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);
INSERT INTO Shipments (N, Num) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1),
(9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 4), (15, 4), 
(16, 4), (17, 4), (18, 4), (19, 4), (20, 4), (21, 4), (22, 4), 
(23, 4), (24, 4), (25, 4), (26, 5), (27, 5), (28, 5), (29, 5), 
(30, 5), (31, 5), (32, 6), (33, 7);
declare @c int;
set @c = 40;

;with table1 as (
	select ordinal as days
	from string_split(replicate(',', 39), ',', 1) 
), 
table2 as (
	select 
		t1.days,
		isnull(s.Num, 0) as Num
	from table1 t1
	left join Shipments s 
	on t1.days=s.N
	),
table3 as (
	select *
	from table2
	order by Num
	offset (@c-1)/2 rows
	fetch next 1+(1-@c%2) rows only
)
select avg(Num) as median
from table3

