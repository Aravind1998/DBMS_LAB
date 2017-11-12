--Creation and Insertion Statements for College Database	\c

create database CollegeDB;

use CollegeDB;

create table STUDENT(USN varchar(10), Student_Name varchar(10), Address varchar(15), Phone varchar(10), Gender varchar(6), Primary Key (USN));

create table SEMSEC(SSID varchar(2), Semester int, Section varchar(1), Primary Key (SSID));

create table CLASS(USN varchar(10), SSID varchar(2), Primary Key (USN), Foreign Key (USN) references STUDENT(USN), Foreign Key (SSID) references SEMSEC(SSID));

create table SUBJECT(Subject_Code varchar(7), Title varchar(5), Semester int, Credits int, Primary Key (Subject_Code));

create table IAMARKS(USN varchar(10), Subject_Code varchar(7), SSID varchar(2), Test1 int, Test2 int, Test3 int, FinalIA int, Primary Key (USN, Subject_Code, SSID), Foreign Key (USN) references STUDENT(USN), Foreign Key (SSID) references SEMSEC(SSID), Foreign Key (Subject_Code) references SUBJECT(Subject_Code));

insert into STUDENT values
('1BI15CS101', 'Anitha', 'Basavanagudi', '9876543212', 'Female'),
('1BI15CS102', 'Sunitha', 'Banashankari', '9876543215', 'Female'),
('1BI15CS103', 'Varsha', 'Koramangala', '9876543214', 'Female'),
('1BI15CS104', 'Ram', 'Koramangala', '9876543216', 'Male'),
('1BI15CS105', 'Shyam', 'Begur', '9876543217', 'Male'),
('1BI15CS106', 'Kumar', 'HSR', '9876543218', 'Male');

insert into SEMSEC values
('S1', 4, 'A'),
('S2', 4, 'C'),
('S3', 5, 'A'),
('S4', 5, 'B'),
('S5', 7, 'A'),
('S6', 7, 'B');

insert into CLASS values
('1BI15CS101', 'S1'),
('1BI15CS102', 'S2'),
('1BI15CS103', 'S3'),
('1BI15CS104', 'S4'),
('1BI15CS105', 'S5'),
('1BI15CS106', 'S6');

insert into SUBJECT values
('15CS053', 'DBMS', 5, 3),
('10CS074', 'DM', 7, 4),
('15CS034', 'DS', 3, 4),
('15CS055', 'ATC', 5, 4),
('10CS075', 'C#', 7, 3),
('15CS035', 'DMS', 3, 3);

insert into IAMARKS values
('1BI15CS101', '15CS053', 'S1', 18, 18, 19, 19),
('1BI15CS102', '10CS074', 'S2', 15, 15, 11, 15),
('1BI15CS103', '15CS034', 'S3', 15, 13, 13, 14),
('1BI15CS104', '15CS055', 'S4', 19, 18, 20, 20),
('1BI15CS105', '10CS075', 'S5', 16, 16, 16, 16),
('1BI15CS106', '15CS035', 'S6', 10, 10, 11, 11),
('1BI15CS101', '15CS055', 'S1', 15, 15, 11, 15),
('1BI15CS102', '10CS075', 'S2', 15, 13, 13, 14),
('1BI15CS103', '15CS035', 'S3', 19, 18, 20, 20),
('1BI15CS104', '15CS053', 'S4', 19, 20, 20, 20),
('1BI15CS105', '10CS074', 'S5', 10, 10, 11, 11),
('1BI15CS106', '15CS034', 'S6', 17, 16, 17, 17);
