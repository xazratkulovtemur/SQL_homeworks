/*task1*/
DROP TABLE if exists student
CREATE TABLE student(
	id int,
	name varchar(50),
	age int
);
select * from student
ALTER TABLE student
ALTER COLUMN id int not null


/*task2*/

DROP TABLE IF EXISTS product
CREATE TABLE product(
	product_id int unique,
	product_name varchar(100),
	price float
);
SELECT name from sys.objects where type='UQ' and parent_object_id =OBJECT_ID('product')
ALTER TABLE product
DROP CONSTRAINT UQ__product__47027DF4FBE5D06B;   --since i didnt give CONSTRAINT name, i should find it to remove constraint

ALTER TABLE product
ADD UNIQUE(product_id)  --adding unique constraint

ALTER TABLE product
ADD UNIQUE(product_id, product_name) --adding constraint to 2 columns



/*task3*/

DROP TABLE IF EXISTS orders
CREATE TABLE orders(
	order_id int primary key,
	order_name varchar(100),
	order_date date
);
SELECT name FROM sys.objects where type='PK' and parent_object_id=OBJECT_ID('orders')
ALTER TABLE orders         --removing constraint 
DROP CONSTRAINT PK__orders__46596229AF2F6D1D

ALTER TABLE orders  --adding constraint again
ADD PRIMARY KEY(order_id)


/*task4*/


DROP TABLE IF EXISTS category
CREATE TABLE category(
	category_id int primary key,
	category_name varchar(50)
);

DROP TABLE if exists item
CREATE TABLE item(
	item_id int primary key,
	item_name varchar(50),
	category_id int foreign key references category(category_id)
);

--idetifying nam eof foreign key

SELECT name from sys.objects where parent_object_id=OBJECT_ID('item')

ALTER TABLE item
DROP CONSTRAINT PK__item__52020FDDB112F008 --REMOVING CONSTRAINT


/*TASK5*/

DROP TABLE IF EXISTS account
CREATE TABLE account(
	account_id int primary key,
	balance DECIMAL check (balance>=0),
	account_type varchar(20) CHECK (account_type IN ('SAVING', 'CHECKING'))
);

SELECT name from sys.objects where parent_object_id=OBJECT_ID('account')
ALTER TABLE account
DROP CONSTRAINT CK__account__balance__4AB81AF0
ALTER TABLE account
DROP CONSTRAINT CK__account__account__4BAC3F29

--INSERT INTO account
--values (1, 100.9, 'h') --checking time

ALTER TABLE account
ADD CONSTRAINT balance check(balance>=0)

ALTER TABLE account
ADD CONSTRAINT account_type CHECK (account_type IN ('SAVING', 'CHECKING'))

/*TASK6*/

DROP TABLE IF EXISTS customer

create table customer(
	customer_id int primary key,
	name varchar(20),
	city varchar(20) DEFAULT 'UNKNOWN'
);


SELECT name from sys.objects where parent_object_id=OBJECT_ID('customer')
ALTER TABLE customer     --identifying name
DROP CONSTRAINT DF__customer__city__534D60F1

ALTER TABLE customer
ADD CONSTRAINT DF__customer__city__534D60F1 DEFAULT 'UNKNOWN' FOR city  --adding constraint again

/*task7*/

DROP TABLE IF EXISTS invoice
CREATE TABLE invoice(
	invoice_id int IDENTITY,
	amount decimal
);

INSERT INTO invoice(amount)
values
	(1.2),
	(1.3),
	(1.4),
	(1.5),
	(1.6);

SELECT * FROM invoice

SET IDENTITY_INSERT invoice ON;
INSERT INTO invoice (invoice_id, amount) VALUES (100, 350.00);

SET IDENTITY_INSERT invoice OFF;

/*TASK8*/

DROP TABLE IF EXISTS books
CREATE TABLE books(
	book_id int primary key IDENTITY, --increase by increament
	title varchar(100) check (title!=''), --check if not empty
	price decimal check(price>=0), --check if not less that 0
	genre varchar(50) DEFAULT 'UNKNOWN' --default value 
);

INSERT INTO books(title, price)
values('Hobbit', 10.4)
  
select * from books




/*task9*/

drop table if exists Book
CREATE TABLE Book(
	book_id int primary key,
	title varchar(50),
	author nvarchar(100),
	published_year int
);

INSERT INTO Book
values
	(1000, 'Hobbit 1', 'someone', 1999), 
	(1001, 'Hobbit 2', 'someone', 2000),
	(1002, 'Hobbit 3', 'someone', 2001);

drop table if exists Member
CREATE TABLE Member(
	member_id int primary key,
	name varchar(50),
	email varchar(100),
	phone_number varchar(20)
);

INSERT INTO Member
values
	(1, 'John', 'john@gmail.com', '911'),
	(2, 'Jane', 'jane@gmail.com', '103');


drop table if exists Loan
CREATE TABLE Loan(
	loan_id int primary key,
	book_id int foreign key references Book(book_id),
	member_id int foreign key references Member(member_id),
	loan_date Date not null,
	return_date Date
);


INSERT INTO Loan
values
	(240100, 1001, 1, '2025-04-04', null),
	(240201, 1000, 2, '2025-03-14', '2025-04-05');


select * from Book
select * from Member 
select * from Loan

