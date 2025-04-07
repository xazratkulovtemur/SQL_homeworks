/*task1*/

CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);
select * from [dbo].[TestMultipleZero] --original table

select *
from [dbo].[TestMultipleZero]
WHERE A <> 0 OR B <> 0 OR C <> 0 OR D <> 0
select * from [dbo].[TestMultipleZero] --filtered table


/*TASK2*/

CREATE TABLE TestMax --table name
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
GO
 
INSERT INTO TestMax  --values
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

SELECT * FROM TestMax;

select Year1, Max(value) as MaxValue --new column
from TestMax
cross apply(
	values(Max1), (Max2),(Max3) --assignning columns to value
) as AllMaxes(value)
group by Year1 --grouping table by Year1

/*task3*/

CREATE TABLE EmpBirth
(
    EmpId INT  IDENTITY(1,1) 
    ,EmpName VARCHAR(50) 
    ,BirthDate DATETIME 
);
 
INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983';

select * from EmpBirth;

select BirthDate --selecting date of birth
from EmpBirth
where month(BirthDate)=5 and day(BirthDate) between 7 and 15; --filtering data

/*task4*/


create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

select* from letters;
select letter
from letters
ORDER BY 
    CASE WHEN letter = 'b' THEN 0 ELSE 1 END,
    letter; --b in first


select letter
from letters
ORDER BY 
    CASE WHEN letter = 'b' THEN 2 ELSE 1 END,
    letter;  --b in last


