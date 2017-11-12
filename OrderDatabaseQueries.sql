--Queries for Order Database	\c


--1. Count the customers with grades above Bangalore’s average.	\c

select count(*) as Customers_Above_Bangalore_Average from CUSTOMER C where C.Grade > (select avg(CU.Grade) from CUSTOMER CU where CU.City = 'Bangalore');
+-----------------------------------+
| Customers_Above_Bangalore_Average |
+-----------------------------------+
|                                 2 |
+-----------------------------------+
1 row in set (0.00 sec)


--2. Find the name and numbers of all salesman who had more than one customer.	\c

select S.Salesman_ID, Salesman_Name, count(*) as No_Of_Customers from SALESMAN S, ORDERS O where S.Salesman_ID = O.Salesman_ID group by O.Salesman_ID having count(*) > 1;
+-------------+---------------+-----------------+
| Salesman_ID | Salesman_Name | No_Of_Customers |
+-------------+---------------+-----------------+
|          10 | Ashok         |               2 |
|          13 | Sowmya        |               2 |
|          14 | Ram           |               3 |
+-------------+---------------+-----------------+
3 rows in set (0.00 sec)


--3. List all the salesman and indicate those who have and don’t have customers in their cities (Use UNION operation.)	\c

select S.Salesman_ID, Salesman_Name, S.City, Commission from SALESMAN S, CUSTOMER C where S.Salesman_ID = C.Salesman_ID and C.City = S.City UNION select S.Salesman_ID, Salesman_Name, S.City, Commission from SALESMAN S, CUSTOMER C where S.Salesman_ID = C.Salesman_ID and C.City <> S.City;
+-------------+---------------+-----------+------------+
| Salesman_ID | Salesman_Name | City      | Commission |
+-------------+---------------+-----------+------------+
|          10 | Ashok         | Bangalore |       1000 |
|          12 | Rachana       | Mysore    |        950 |
|          11 | Sanath        | Mangalore |        900 |
|          14 | Ram           | Bangalore |       1500 |
|          13 | Sowmya        | Raichur   |        700 |
+-------------+---------------+-----------+------------+
5 rows in set (0.00 sec)


--4. Create a view that finds the salesman who has the customer with the highest order of a day.	\c

create view HIGHEST_ORDER_OF_THE_DAY as (select Order_Date, S.Salesman_ID, Salesman_Name, max(Purchase_Amount) as Max_Sales from ORDERS O, SALESMAN S where S.Salesman_ID = O.Salesman_ID and Purchase_Amount = (select max(Purchase_Amount) from ORDERS ORD where O.Order_Date = ORD.Order_Date) group by Order_Date);
Query OK, 0 rows affected (0.04 sec)
--\c

show tables;
+--------------------------+
| Tables_in_OrderDB        |
+--------------------------+
| CUSTOMER                 |
| HIGHEST_ORDER_OF_THE_DAY |
| ORDERS                   |
| SALESMAN                 |
+--------------------------+
4 rows in set (0.00 sec)
--\c

select * from HIGHEST_ORDER_OF_THE_DAY;
+------------+-------------+---------------+-----------+
| Order_Date | Salesman_ID | Salesman_Name | Max_Sales |
+------------+-------------+---------------+-----------+
| 2017-01-15 |          14 | Ram           |     26000 |
| 2017-01-16 |          13 | Sowmya        |     18000 |
| 2017-01-17 |          11 | Sanath        |     12000 |
| 2017-01-25 |          13 | Sowmya        |     18000 |
| 2017-01-26 |          10 | Ashok         |     14000 |
| 2017-01-30 |          14 | Ram           |     20000 |
+------------+-------------+---------------+-----------+
6 rows in set (0.00 sec)


--5. Demonstrate the DELETE operation by removing salesman with id 10. All his orders must also be deleted.	\c

delete from SALESMAN where Salesman_ID = 10;
Query OK, 1 row affected (0.05 sec)
--\c

select * from SALESMAN;
+-------------+---------------+-----------+------------+
| Salesman_ID | Salesman_Name | City      | Commission |
+-------------+---------------+-----------+------------+
|          11 | Sanath        | Mangalore |        900 |
|          12 | Rachana       | Mysore    |        950 |
|          13 | Sowmya        | Raichur   |        700 |
|          14 | Ram           | Bangalore |       1500 |
|          15 | Rajesh        | Chennai   |        700 |
+-------------+---------------+-----------+------------+
5 rows in set (0.00 sec)
--\c

select * from CUSTOMER;
+-------------+---------------+-----------+-------+-------------+
| Customer_ID | Customer_Name | City      | Grade | Salesman_ID |
+-------------+---------------+-----------+-------+-------------+
| C2          | Raman         | Mysore    |    40 |          12 |
| C3          | Koushalya     | Mangalore |    30 |          11 |
| C4          | Lakshmi       | Bangalore |    50 |          14 |
| C5          | Priya         | Raichur   |    20 |          13 |
| C6          | Rahul         | Bangalore |    20 |          13 |
+-------------+---------------+-----------+-------+-------------+
5 rows in set (0.00 sec)
--\c

select * from ORDERS;
+----------+-----------------+------------+-------------+-------------+
| Order_No | Purchase_Amount | Order_Date | Customer_ID | Salesman_ID |
+----------+-----------------+------------+-------------+-------------+
|        2 |           15000 | 2017-01-15 | C2          |          12 |
|        4 |           12000 | 2017-01-17 | C3          |          11 |
|        5 |           20000 | 2017-01-30 | C4          |          14 |
|        6 |           18000 | 2017-01-25 | C5          |          13 |
|        8 |           18000 | 2017-01-16 | C6          |          13 |
|        9 |           26000 | 2017-01-15 | C3          |          14 |
+----------+-----------------+------------+-------------+-------------+
6 rows in set (0.00 sec)
--\c

