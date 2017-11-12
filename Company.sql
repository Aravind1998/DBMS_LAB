--Creation and Insertion Statements for Company Database	\c

create database CompanyDB;

use CompanyDB;

create table EMPLOYEE(SSN varchar(10), Employee_First_Name varchar(10), Employee_Last_Name varchar(10), Address varchar(30), Sex varchar(1), Salary int, Primary Key (SSN));

create table DEPARTMENT(Department_No int, Department_Name varchar(15), Manager_SSN varchar(10), Manager_Start_Date date, Primary Key (Department_No), Foreign Key (Manager_SSN) references EMPLOYEE(SSN));

alter table EMPLOYEE add column(Supervisor_SSN varchar(10), Department_No int, Foreign Key (Supervisor_SSN) references EMPLOYEE(SSN), Foreign Key (Department_No) references DEPARTMENT(Department_No));

create table DLOCATION(Department_No int, Department_Location varchar(10), Primary Key (Department_No, Department_Location), Foreign Key (Department_No) references DEPARTMENT(Department_No));

create table PROJECT(Project_No int, Project_Name varchar(15), Project_Location varchar(10), Department_No int, Primary Key (Project_No), Foreign Key (Department_No) references DEPARTMENT(Department_No));

create table WORKS_ON(SSN varchar(10), Project_No int, Hours float, Primary Key (SSN, Project_No), Foreign Key (SSN) references EMPLOYEE(SSN), Foreign Key (Project_No) references PROJECT(Project_No));

insert into EMPLOYEE values
('123456789', 'John', 'Smith', '731 Fondren, Houston, TX', 'M', 550000, NULL, NULL),
('333445555', 'Franklin', 'Scott', '638 Voss, Houston, TX', 'M', 650000, NULL, NULL),
('999887777', 'Alicia', 'Zelaya', '3321 Castle, Spring, TX', 'F', 450000, NULL, NULL),
('987654321', 'Jennifer', 'Wallace', '291 Berry, Bellaire, TX', 'F', 700000, NULL, NULL),
('666884444', 'Ramesh', 'Narayan', '975 Fire Oak, Humble, TX', 'M', 650000, NULL, NULL),
('453453453', 'Joyce', 'English', '5631 Rice, Houston, TX', 'F', 350000, NULL, NULL),
('987987987', 'Ahmad', 'Jabbar', '980 Dallas, Houston, TX', 'M', 450000, NULL, NULL),
('888665555', 'James', 'Borg', '450 Stone, Houston, TX', 'M', 800000, NULL, NULL);

insert into DEPARTMENT values
(5, 'Research', '333445555', '1988-05-22'),
(4, 'Accounts', '987654321', '1995-01-01'),
(1, 'Headquarters', '888665555', '1981-06-19');

update EMPLOYEE set
Supervisor_SSN = '333445555',
Department_No = 5 
where SSN = '123456789';

update EMPLOYEE set
Supervisor_SSN = '888665555',
Department_No = 5 
where SSN = '333445555';

update EMPLOYEE set
Supervisor_SSN = '987654321',
Department_No = 4 
where SSN = '999887777';

update EMPLOYEE set
Supervisor_SSN = '888665555',
Department_No = 4 
where SSN = '987654321';

update EMPLOYEE set
Supervisor_SSN = '333445555',
Department_No = 5 
where SSN = '666884444';

update EMPLOYEE set
Supervisor_SSN = '333445555',
Department_No = 5 
where SSN = '453453453';

update EMPLOYEE set
Supervisor_SSN = '987654321',
Department_No = 4 
where SSN = '987987987';

update EMPLOYEE set
Department_No = 1 
where SSN = '888665555';

insert into DLOCATION values
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston');

insert into PROJECT values
(1, 'IoT', 'Bellaire', 5),
(2, 'Product Y', 'Sugarland', 5),
(3, 'Product Z', 'Houston', 5),
(10, 'Computerization', 'Stafford', 4),
(20, 'Reorganization', 'Houston', 1),
(30, 'Newbenefits', 'Stafford', 4);

insert into WORKS_ON values
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, NULL);

