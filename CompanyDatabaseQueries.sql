--Queries for College Database


--1. Make a list of all project numbers for projects that involve an employee whose last name is ‘Scott’, either as a worker or as a manager of the department that controls the project.	\c

select distinct(P.Project_No), Project_Name from PROJECT P, WORKS_ON W, EMPLOYEE E, DEPARTMENT D where Employee_Last_Name = 'Scott' and ((W.SSN = E.SSN and W.Project_No = P.Project_No) or (E.SSN = D.Manager_SSN and D.Department_No = P.Department_No));
+------------+-----------------+
| Project_No | Project_Name    |
+------------+-----------------+
|          1 | IoT             |
|          2 | Product Y       |
|          3 | Product Z       |
|         10 | Computerization |
|         20 | Reorganization  |
+------------+-----------------+
5 rows in set (0.00 sec)


--2. Show the resulting salaries if every employee working on the ‘IoT’ project is given a 10 percent raise.	\c

select E.SSN, Employee_First_Name, Employee_Last_Name, round((Salary + (.1 * Salary)), 2) as Updated_Salary from EMPLOYEE E, WORKS_ON W, PROJECT P where P.Project_No = W.Project_No and W.SSN = E.SSN and Project_Name = 'IoT';
+-----------+---------------------+--------------------+----------------+
| SSN       | Employee_First_Name | Employee_Last_Name | Updated_Salary |
+-----------+---------------------+--------------------+----------------+
| 123456789 | John                | Smith              |      605000.00 |
| 453453453 | Joyce               | English            |      385000.00 |
+-----------+---------------------+--------------------+----------------+
2 rows in set (0.00 sec)


--3. Find the sum of the salaries of all employees of the ‘Accounts’ department, as well as the maximum salary, the minimum salary, and the average salary in this department.	\c

select Department_Name, sum(Salary) as Sum_Of_Salaries, max(Salary) as Maximum_Salary, min(Salary) as Minimum_Salary, round(avg(Salary), 2) as Average_Salary from DEPARTMENT D, EMPLOYEE E where D.Department_No = E.Department_No and Department_Name = 'Accounts';
+-----------------+-----------------+----------------+----------------+----------------+
| Department_Name | Sum_Of_Salaries | Maximum_Salary | Minimum_Salary | Average_Salary |
+-----------------+-----------------+----------------+----------------+----------------+
| Accounts        |         1600000 |         700000 |         450000 |      533333.33 |
+-----------------+-----------------+----------------+----------------+----------------+
1 row in set (0.00 sec)


--4. Retrieve the name of each employee who works on all the projects controlled by department number 4 (use NOT EXISTS operator).	\c

select Employee_First_Name, Employee_Last_Name from EMPLOYEE E where not exists (select Project_No from PROJECT where Department_No = 4 and Project_No not in (select Project_No from WORKS_ON W where W.SSN = E.SSN));
+---------------------+--------------------+
| Employee_First_Name | Employee_Last_Name |
+---------------------+--------------------+
| Ahmad               | Jabbar             |
| Alicia              | Zelaya             |
+---------------------+--------------------+
2 rows in set (0.00 sec)


--5. For each department that has more than two employees, retrieve the department number and the number of its employees who are making more than Rs. 6,00,000.	\c

select E.Department_No, D.Department_Name, count(*) as Employees_With_Salary_Greater_Than_600000 from EMPLOYEE E, DEPARTMENT D where E.Salary > 600000 and E.Department_No = D.Department_No and E.Department_No in (select EM.Department_No from EMPLOYEE EM group by EM.Department_No having count(*) > 2) group by E.Department_No;
+---------------+-----------------+-------------------------------------------+
| Department_No | Department_Name | Employees_With_Salary_Greater_Than_600000 |
+---------------+-----------------+-------------------------------------------+
|             4 | Accounts        |                                         1 |
|             5 | Research        |                                         2 |
+---------------+-----------------+-------------------------------------------+
2 rows in set (0.00 sec)
--\c

