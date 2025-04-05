/*task1*/

CREATE SCHEMA Lesson_2
go

DROP TABLE IF EXISTS Lesson_2.test_identity
CREATE TABLE Lesson_2.test_identity(
	id int IDENTITY, --DEFAULT VALUE (1,1)
	fname varchar(50)
);

INSERT INTO Lesson_2.test_identity(fname)
VALUES
	('John'),
	('Ann'),
	('Bob'),
	('Tris'),
	('Jane');


select * from Lesson_2.test_identity

--1st case using DELETE
DELETE FROM Lesson_2.test_identity
select * from Lesson_2.test_identity
--I seeall value has been deleted

INSERT INTO Lesson_2.test_identity(fname)
values ('Temur')
select * from Lesson_2.test_identity
--Now, when i insert new row, id starts form 6, coz DELETE erases data but not reset identity value

--2nd case using Trucate

TRUNCATE TABLE Lesson_2.test_identity
select * from Lesson_2.test_identity

--it also deleted every value
INSERT INTO Lesson_2.test_identity(fname)
values ('Temur')
select * from Lesson_2.test_identity
--But i see it also resets IDENTITY VALUE

--NOW, WITH DROP

DROP TABLE Lesson_2.test_identity
select * from Lesson_2.test_identity 
--Invalid object name 'Lesson_2.test_identity'.   since it deleted that table





/*task2*/


DROP TABLE IF EXISTS Lesson_2.Common
CREATE TABLE Lesson_2.Common(
	num1 tinyint,
	num2 smallint,
	num3 int,
	num4 bigint,
	dec1 decimal(10,2),
	fl1 float,
	date1 DATE,
	time1 TIME,
	DATETIME1 DATETIME,
	id UNIQUEIDENTIFIER
);


INSERT INTO Lesson_2.Common 
values
	(10, 3000, 1000000, 100000000000000, 3.14123, 10.125, '2025-04-05', '11-12-12', GETDATE(), NEWID());

select * from Lesson_2.Common



/*task3*/


DROP TABLE IF EXISTS Lesson_2.photo
CREATE TABLE  Lesson_2.photo(
	id int IDENTITY,
	photo_data VARBINARY(max)
);

INSERT INTO Lesson_2.photo(photo_data)
SELECT BulkColumn 
FROM OPENROWSET(BULK 'D:\MAAB\SQL\SQL_homeworks\lesson-2\homework\APPLE.jpg', SINGLE_BLOB) AS img;
--folliwing tasks in python file

/*task4*/


DROP TABLE IF EXISTS Lesson_2.computed_table
CREATE TABLE Lesson_2.computed_table(
	product_name varchar(50),
	quantity int,
	price decimal(10,2),
	total_cost AS (quantity * price) --computing
);

INSERT INTO Lesson_2.computed_table
values
	('apple', 3, 10.99),
	('meat', 2, 120000.799),
	('bread', 4, 3700.399)

select* from Lesson_2.computed_table

/*task5*/

DROP TABLE IF EXISTS Lesson_2.username
CREATE TABLE Lesson_2.username(
	Username varchar(50),
	Id int primary key,
	fname varchar(50),
	lname varchar(50)
);

BULK INSERT Lesson_2.username
FROM 'D:\MAAB\SQL\SQL_homeworks\lesson-2\homework\username.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n'
    
);


select * from Lesson_2.username --displaying data