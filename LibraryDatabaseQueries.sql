--Queries for Library Database	\c


--1. Retrieve details of all books in the library – id, title, name of publisher, authors, number of copies in each branch, etc.	\c

select Branch_ID, Title, Publisher_Name, Author_Name, No_Of_Copies from BOOK_COPIES C, BOOK_AUTHORS A, BOOK B where C.Book_ID = B.Book_ID and B.Book_ID = A.Book_ID;
+-----------+-------+----------------+-------------+--------------+
| Branch_ID | Title | Publisher_Name | Author_Name | No_Of_Copies |
+-----------+-------+----------------+-------------+--------------+
|        11 | DBMS  | Pearson        | Navathe     |           10 |
|        22 | DBMS  | Pearson        | Navathe     |           13 |
|        33 | DBMS  | Pearson        | Navathe     |           18 |
|        22 | DS    | TMH            | Teninbaum   |           20 |
|        33 | DS    | TMH            | Teninbaum   |           15 |
|        11 | DM    | TMH            | Galvin      |           15 |
|        22 | DM    | TMH            | Galvin      |           14 |
|        33 | DM    | TMH            | Galvin      |            6 |
|        44 | DM    | TMH            | Galvin      |           30 |
|        22 | DAA   | Pearson        | Navathe     |           16 |
|        44 | DAA   | Pearson        | Navathe     |           12 |
|        55 | DAA   | Pearson        | Navathe     |           17 |
|        55 | OS    | GK             | Kurose      |           25 |
+-----------+-------+----------------+-------------+--------------+
13 rows in set (0.00 sec)


--2. Get the particulars of borrowers who have borrowed more than 3 books, but from Jan 2017 to Jun 2017.	\c

select * from BOOK_LENDING where Card_No in (select Card_No from BOOK_LENDING L where Date_Out between '2017-01-01' and '2017-06-01' group by Card_No having count(*) > 3);
+---------+-----------+---------+------------+------------+
| Book_ID | Branch_ID | Card_No | Date_Out   | Due_Date   |
+---------+-----------+---------+------------+------------+
|       1 |        11 |     111 | 2017-01-01 | 2017-02-28 |
|       2 |        33 |     111 | 2017-02-01 | 2017-03-31 |
|       3 |        22 |     111 | 2017-04-01 | 2017-05-31 |
|       4 |        44 |     111 | 2017-06-01 | 2017-07-31 |
+---------+-----------+---------+------------+------------+
4 rows in set (0.00 sec)


--3. Delete a book in BOOK table. Update the contents of other tables to reflect this data manipulation operation.	\c

delete from BOOK where Book_ID = 3;
Query OK, 1 row affected (0.33 sec)
--\c

select * from BOOK;
+---------+-------+--------------+----------------+
| Book_ID | Title | Publish_Year | Publisher_Name |
+---------+-------+--------------+----------------+
|       1 | DBMS  | 2017-07-01   | Pearson        |
|       2 | DS    | 2015-01-01   | TMH            |
|       4 | DAA   | 2017-01-01   | Pearson        |
|       5 | OS    | 2017-05-01   | GK             |
+---------+-------+--------------+----------------+
4 rows in set (0.00 sec)
--\c

select * from BOOK_AUTHORS;
+---------+-------------+
| Book_ID | Author_Name |
+---------+-------------+
|       1 | Navathe     |
|       2 | Teninbaum   |
|       4 | Navathe     |
|       5 | Kurose      |
+---------+-------------+
4 rows in set (0.00 sec)
--\c

select * from BOOK_COPIES;
+---------+-----------+--------------+
| Book_ID | Branch_ID | No_Of_Copies |
+---------+-----------+--------------+
|       1 |        11 |           10 |
|       1 |        22 |           13 |
|       1 |        33 |           18 |
|       2 |        22 |           20 |
|       2 |        33 |           15 |
|       4 |        22 |           16 |
|       4 |        44 |           12 |
|       4 |        55 |           17 |
|       5 |        55 |           25 |
+---------+-----------+--------------+
9 rows in set (0.00 sec)
--\c

select * from BOOK_LENDING;
+---------+-----------+---------+------------+------------+
| Book_ID | Branch_ID | Card_No | Date_Out   | Due_Date   |
+---------+-----------+---------+------------+------------+
|       1 |        11 |     111 | 2017-01-01 | 2017-02-28 |
|       1 |        22 |     222 | 2015-01-01 | 2015-02-28 |
|       2 |        33 |     111 | 2017-02-01 | 2017-03-31 |
|       2 |        33 |     222 | 2017-08-01 | 2017-09-30 |
|       4 |        22 |     222 | 2016-09-01 | 2016-10-31 |
|       4 |        44 |     111 | 2017-06-01 | 2017-07-31 |
|       4 |        55 |     555 | 2017-01-01 | 2017-03-31 |
+---------+-----------+---------+------------+------------+
7 rows in set (0.00 sec)


--4. Partition the BOOK table based on year of publication. Demonstrate its working with a simple query.	\c

create view BOOKS_FROM_2013_TO_2015 as (select * from BOOK where year(Publish_Year) between 2013 and 2015);
Query OK, 0 rows affected (0.05 sec)
--\c

create view BOOKS_FROM_2016_TO_2017 as (select * from BOOK where year(Publish_Year) between 2016 and 2017);
Query OK, 0 rows affected (0.07 sec)
--\c

show tables;
+-------------------------+
| Tables_in_LibraryDB     |
+-------------------------+
| BOOK                    |
| BOOKS_FROM_2013_TO_2015 |
| BOOKS_FROM_2016_TO_2017 |
| BOOK_AUTHORS            |
| BOOK_COPIES             |
| BOOK_LENDING            |
| LIBRARY_BRANCH          |
| PUBLISHER               |
+-------------------------+
8 rows in set (0.00 sec)
--\c

select * from BOOKS_FROM_2013_TO_2015;
+---------+-------+--------------+----------------+
| Book_ID | Title | Publish_Year | Publisher_Name |
+---------+-------+--------------+----------------+
|       2 | DS    | 2015-01-01   | TMH            |
+---------+-------+--------------+----------------+
1 row in set (0.00 sec)
--\c

select * from BOOKS_FROM_2016_TO_2017;
+---------+-------+--------------+----------------+
| Book_ID | Title | Publish_Year | Publisher_Name |
+---------+-------+--------------+----------------+
|       1 | DBMS  | 2017-07-01   | Pearson        |
|       4 | DAA   | 2017-01-01   | Pearson        |
|       5 | OS    | 2017-05-01   | GK             |
+---------+-------+--------------+----------------+
3 rows in set (0.00 sec)


--5. Create a view of all books and its number of copies that are currently available in the Library.	\c

create view NUMBER_OF_AVAILABLE_COPIES as(select C.Book_ID, C.Branch_ID, (No_Of_Copies - count(L.Card_No)) as No_Of_Available_Copies from BOOK_COPIES C LEFT JOIN BOOK_LENDING L ON (L.Book_ID = C.BOOK_ID and L.Branch_ID = C.Branch_ID) and L.Due_Date > '2017-01-12' and L.Date_Out <= '2017-01-12' group by C.Book_ID, C.Branch_ID);
Query OK, 0 rows affected (0.05 sec)
--\c

show tables;
+----------------------------+
| Tables_in_LibraryDB        |
+----------------------------+
| BOOK                       |
| BOOKS_FROM_2013_TO_2015    |
| BOOKS_FROM_2016_TO_2017    |
| BOOK_AUTHORS               |
| BOOK_COPIES                |
| BOOK_LENDING               |
| LIBRARY_BRANCH             |
| NUMBER_OF_AVAILABLE_COPIES |
| PUBLISHER                  |
+----------------------------+
9 rows in set (0.00 sec)
--\c

select * from NUMBER_OF_AVAILABLE_COPIES;
+---------+-----------+------------------------+
| Book_ID | Branch_ID | No_Of_Available_Copies |
+---------+-----------+------------------------+
|       1 |        11 |                      9 |
|       1 |        22 |                     13 |
|       1 |        33 |                     18 |
|       2 |        22 |                     20 |
|       2 |        33 |                     15 |
|       4 |        22 |                     16 |
|       4 |        44 |                     12 |
|       4 |        55 |                     16 |
|       5 |        55 |                     25 |
+---------+-----------+------------------------+
9 rows in set (0.00 sec)
--\c

