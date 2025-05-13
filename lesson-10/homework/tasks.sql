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
	)
select avg(Num*1.0) as Median
from table2 
where days in (20,21)

