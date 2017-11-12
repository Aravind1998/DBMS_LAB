--Creation and Insertion Statements for Library Database	\c

create database LibraryDB;

use LibraryDB;

create table PUBLISHER(Name varchar(10), Phone varchar(10), Address varchar(10), Primary Key (Name));

create table BOOK(Book_ID int, Title varchar(5), Publish_Year date, Publisher_Name varchar(10), Primary Key (Book_ID), Foreign Key (Publisher_Name) references PUBLISHER(Name) on delete cascade);

create table BOOK_AUTHORS(Book_ID int, Author_Name varchar(10), Primary Key (Book_ID), Foreign Key (Book_ID) references BOOK(Book_ID) on delete cascade);

create table LIBRARY_BRANCH(Branch_ID int, Address varchar(15), Branch_Name varchar(15), Primary Key (Branch_ID));

create table BOOK_COPIES(Book_ID int, Branch_ID int, No_Of_Copies int, Primary Key (Book_ID, Branch_ID), Foreign Key (Book_ID) references BOOK(Book_ID) on delete cascade, Foreign Key (Branch_ID) references LIBRARY_BRANCH(Branch_ID) on delete cascade);

create table BOOK_LENDING(Book_ID int, Branch_ID int, Card_No int, Date_Out date, Due_Date date, Primary Key (Book_ID, Branch_ID, Card_No), Foreign Key (Book_ID) references BOOK(Book_ID) on delete cascade, Foreign Key (Branch_ID) references LIBRARY_BRANCH(Branch_ID) on delete cascade);

insert into PUBLISHER values
('Pearson', '9876543212',  'Bangalore'),
('TMH', '9876543215', 'Delhi'), 
('Orielly','9876543214', 'Hydrabad'),
('EEE', '9876543216',  'Chennai'),
('GK', '9876543217', 'Kolkata');

insert into BOOK values
(1, 'DBMS', '2017-07-01', 'Pearson'),
(2, 'DS', '2015-01-01', 'TMH'),
(3, 'DM', '2012-08-01', 'TMH'),
(4, 'DAA', '2017-01-01', 'Pearson'),
(5, 'OS', '2017-05-01', 'GK');

insert into BOOK_AUTHORS values
(1, 'Navathe'),
(2, 'Teninbaum'),
(3, 'Galvin'),
(4, 'Navathe'),
(5, 'Kurose');

insert into LIBRARY_BRANCH values
(11, 'E-city', 'Bangalore-south'),
(22, 'Gandhi nagar', 'Bangalore-north'),
(33, 'Basavanagudi', 'Bangalore-west'),
(44, 'Malleswaram', 'Bangalore-east'),
(55, 'Banashankari', 'Bangalore');

insert into BOOK_COPIES values
(1, 11, 10),
(1, 22, 13),
(2, 22, 20),
(2, 33, 15),
(3, 11, 15),
(3, 33, 6),
(3, 22, 14),
(1, 33, 18),
(4, 44, 12),
(4, 55, 17),
(4, 22, 16),
(5, 55, 25),
(3, 44, 30);

insert into BOOK_LENDING values
(1, 11, 111, '2017-01-01', '2017-02-28'),
(2, 33, 111, '2017-02-01', '2017-03-31'),
(1, 22, 222, '2015-01-01', '2015-02-28'),
(3, 33, 222, '2017-03-01', '2017-04-30'),
(4, 55, 555, '2017-01-01', '2017-03-31'),
(3, 22, 111, '2017-04-01', '2017-05-31'),
(4, 44, 111, '2017-06-01', '2017-07-31'),
(2, 33, 222, '2017-08-01', '2017-09-30'),
(4, 22, 222, '2016-09-01', '2016-10-31');

