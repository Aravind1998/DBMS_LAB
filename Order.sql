--Creation and Insertion Statements for Order Database	\c

create database OrderDB;

use OrderDB;

create table SALESMAN(Salesman_ID int, Salesman_Name varchar(10), City varchar(10), Commission int, Primary Key (Salesman_ID));

create table CUSTOMER(Customer_ID varchar(2), Customer_Name varchar(10), City varchar(10), Grade int, Salesman_ID int, Primary Key (Customer_ID), Foreign Key (Salesman_ID) references SALESMAN(Salesman_ID) on delete cascade);

create table ORDERS(Order_No int, Purchase_Amount int, Order_Date date, Customer_ID varchar(2), Salesman_ID int, Primary Key (Order_No), Foreign Key (Salesman_ID) references SALESMAN(Salesman_ID) on delete cascade, Foreign Key (Customer_ID) references CUSTOMER(Customer_ID) on delete cascade);

insert into SALESMAN values
(10, 'Ashok', 'Bangalore', 1000),
(11, 'Sanath', 'Mangalore', 900),
(12, 'Rachana', 'Mysore', 950),
(13, 'Sowmya', 'Raichur', 700),
(14, 'Ram', 'Bangalore', 1500),
(15, 'Rajesh', 'Chennai', 700);

insert into CUSTOMER values
('C1', 'Radha', 'Bangalore', 50, 10),
('C2', 'Raman', 'Mysore', 40, 12),
('C3', 'Koushalya', 'Mangalore', 30, 11),
('C4', 'Lakshmi', 'Bangalore', 50, 14),
('C5', 'Priya', 'Raichur', 20, 13),
('C6', 'Rahul', 'Bangalore', 20, 13);

insert into ORDERS values
(1, 10000, '2017-01-15', 'C1', 10),
(2, 15000, '2017-01-15', 'C2', 12),
(3, 9000,  '2017-01-30', 'C1', 14),
(4, 12000, '2017-01-17', 'C3', 11),
(5, 20000, '2017-01-30', 'C4', 14),
(6, 18000, '2017-01-25', 'C5', 13),
(7, 14000, '2017-01-26', 'C1', 10),
(8, 18000, '2017-01-16', 'C6', 13),
(9, 26000, '2017-01-15', 'C3', 14);

