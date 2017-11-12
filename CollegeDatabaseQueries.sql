--Queries for College Database


--1. List all the student details studying in fourth semester ‘C’ section.	\c

select * from STUDENT where USN in (select USN from CLASS C, SEMSEC S where C.SSID = S.SSID and Semester = 4 and Section = 'C');
+------------+--------------+--------------+------------+--------+
| USN        | Student_Name | Address      | Phone      | Gender |
+------------+--------------+--------------+------------+--------+
| 1BI15CS102 | Sunitha      | Banashankari | 9876543215 | Female |
+------------+--------------+--------------+------------+--------+
1 row in set (0.00 sec)


--2. Compute the total number of male and female students in each semester and in each section.	\c

select Semester, Section, count(case when Gender = 'Female' then 1 end) as Number_Of_Females, count(case when Gender = 'Male' then 1 end) as Number_Of_Males from STUDENT S, SEMSEC SS, CLASS C where C.USN = S.USN and C.SSID = SS.SSID group by Semester, Section;
+----------+---------+-------------------+-----------------+
| Semester | Section | Number_Of_Females | Number_Of_Males |
+----------+---------+-------------------+-----------------+
|        4 | A       |                 1 |               0 |
|        4 | C       |                 1 |               0 |
|        5 | A       |                 1 |               0 |
|        5 | B       |                 0 |               1 |
|        7 | A       |                 0 |               1 |
|        7 | B       |                 0 |               1 |
+----------+---------+-------------------+-----------------+
6 rows in set (0.00 sec)


--3. Create a view of Test1 marks of student USN ‘1BI15CS101’ in all subjects.	\c

create view TEST_1_MARKS_OF_1BI15CS101 as (select Subject_Code, Test1 from IAMARKS where USN = '1BI15CS101');
Query OK, 0 rows affected (0.04 sec)
--\c

show tables;
+----------------------------+
| Tables_in_CollegeDB        |
+----------------------------+
| CLASS                      |
| IAMARKS                    |
| SEMSEC                     |
| STUDENT                    |
| SUBJECT                    |
| TEST_1_MARKS_OF_1BI15CS101 |
+----------------------------+
6 rows in set (0.00 sec)
--\c

select * from TEST_1_MARKS_OF_1BI15CS101;
+--------------+-------+
| Subject_Code | Test1 |
+--------------+-------+
| 15CS053      |    18 |
| 15CS055      |    15 |
+--------------+-------+
2 rows in set (0.00 sec)


--4. Calculate the FinalIA (average of best two test marks) and update the corresponding table for all students.	\c

delimiter //

create procedure FinalMarks89 ()
    begin
        declare t1 int;
        declare t2 int;
        declare t3 int;
        declare student_usn varchar(10);
        declare subCode varchar(7);
        declare finalAvg int;
        declare cur1 cursor for select USN, Subject_Code, Test1, Test2, Test3 from IAMARKS;
        open cur1;
        loop
            FETCH cur1 into student_usn, subCode, t1, t2, t3;
            set finalAvg = ((t1 + t2 + t3) - least(t1, t2, t3)) / 2;
            update IAMARKS set FinalIA = finalAvg where USN = student_usn and Subject_Code = subCode;
        end loop;
        close cur1;
    end//


delimiter ;
Query OK, 0 rows affected (0.01 sec)
--\c

delimiter ;

select * from IAMARKS;
+------------+--------------+------+-------+-------+-------+---------+
| USN        | Subject_Code | SSID | Test1 | Test2 | Test3 | FinalIA |
+------------+--------------+------+-------+-------+-------+---------+
| 1BI15CS101 | 15CS053      | S1   |    18 |    18 |    19 |      19 |
| 1BI15CS101 | 15CS055      | S1   |    15 |    15 |    11 |      15 |
| 1BI15CS102 | 10CS074      | S2   |    15 |    15 |    11 |      15 |
| 1BI15CS102 | 10CS075      | S2   |    15 |    13 |    13 |      14 |
| 1BI15CS103 | 15CS034      | S3   |    15 |    13 |    13 |      14 |
| 1BI15CS103 | 15CS035      | S3   |    19 |    18 |    20 |      20 |
| 1BI15CS104 | 15CS053      | S4   |    19 |    20 |    20 |      20 |
| 1BI15CS104 | 15CS055      | S4   |    19 |    18 |    20 |      20 |
| 1BI15CS105 | 10CS074      | S5   |    10 |    10 |    11 |      11 |
| 1BI15CS105 | 10CS075      | S5   |    16 |    16 |    16 |      16 |
| 1BI15CS106 | 15CS034      | S6   |    17 |    16 |    17 |      17 |
| 1BI15CS106 | 15CS035      | S6   |    10 |    10 |    11 |      11 |
+------------+--------------+------+-------+-------+-------+---------+
12 rows in set (0.00 sec)


--5. Categorize students based on the following criterion:	\c
--	If FinalIA = 17 to 20 then CAT = ‘Outstanding’
--	If FinalIA = 12 to 16 then CAT = ‘Average’
--	If FinalIA< 12 then CAT = ‘Weak’
--	Give these details only for 8th semester A, B, and C section students.	\c

create view STUDENT_CATEGORY as (select Student_Name, Semester, Section, Subject_Code, (case when FinalIA between 17 and 20 then 'Outstanding' when FinalIA between 12 and 16 then 'Average' when FinalIA between 0 and 11 then 'Weak' end) as Category from STUDENT S, SEMSEC SS, CLASS C, IAMARKS IA where S.USN = C.USN and SS.SSID = C.SSID and IA.USN = S.USN and Semester = 7 and (Section = 'A' or Section = 'B' or Section = 'C'));
Query OK, 0 rows affected (0.04 sec)
--\c

show tables;
+---------------------+
| Tables_in_CollegeDB |
+---------------------+
| CLASS               |
| IAMARKS             |
| SEMSEC              |
| STUDENT             |
| STUDENT_CATEGORY    |
| SUBJECT             |
+---------------------+
6 rows in set (0.01 sec)
--\c

select * from STUDENT_CATEGORY;
+--------------+----------+---------+--------------+-------------+
| Student_Name | Semester | Section | Subject_Code | Category    |
+--------------+----------+---------+--------------+-------------+
| Shyam        |        7 | A       | 10CS074      | Weak        |
| Shyam        |        7 | A       | 10CS075      | Average     |
| Kumar        |        7 | B       | 15CS034      | Outstanding |
| Kumar        |        7 | B       | 15CS035      | Weak        |
+--------------+----------+---------+--------------+-------------+
4 rows in set (0.00 sec)
--\c

