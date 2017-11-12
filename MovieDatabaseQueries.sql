--Queries for Movie Database	\c


--1. List the titles of all movies directed by ‘Hitchcock’.	\c

select Movie_Title from MOVIE M, DIRECTOR D where Director_Name = 'Hitchcock' and D.Director_ID = M.Director_ID;
+-------------------+
| Movie_Title       |
+-------------------+
| Mythr - My Friend |
+-------------------+
1 row in set (0.00 sec)


--2. Find the movie names where one or more actors acted in two or more movies.	\c

select Movie_Title from MOVIE M where exists (select * from MOVIE_CAST C where M.Movie_ID = C.Movie_ID and Actor_ID in (select MC.Actor_ID from MOVIE_CAST MC group by Actor_ID having count(*) >= 2));
+-------------------------+
| Movie_Title             |
+-------------------------+
| Operation Diamond Raket |
| Malgudi Days            |
| Ehega                   |
| Mummy                   |
+-------------------------+
4 rows in set (0.00 sec)


--3. List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation).	\c

select A.Actor_ID, Actor_Name from ACTOR A JOIN (select P.Actor_ID from (select MC.Actor_ID, MC.Movie_ID from MOVIE_CAST MC JOIN MOVIE M ON M.Movie_ID = MC.Movie_ID where Year > 2015) as P JOIN (select MC.Actor_ID, MC.Movie_ID from MOVIE_CAST MC JOIN MOVIE M ON M.Movie_ID = MC.Movie_ID where Year < 2000) as Q ON P.Actor_ID = Q.Actor_ID) as T ON A.Actor_ID = T.Actor_ID;
+----------+------------+
| Actor_ID | Actor_Name |
+----------+------------+
|        4 | Shankarnag |
+----------+------------+
1 row in set (0.00 sec)


--4. Find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie received. Sort the result by movie title.	\c

select Movie_Title, count(*) as Number_Of_Reviews, max(Review_Stars) as Highest_Review_Stars from MOVIE M, RATING R where M.Movie_ID = R.Movie_ID group by R.Movie_ID having count(*) >= 1 order by Movie_Title;
+-------------------------+-------------------+----------------------+
| Movie_Title             | Number_Of_Reviews | Highest_Review_Stars |
+-------------------------+-------------------+----------------------+
| Ehega                   |                 2 |                    3 |
| Malgudi Days            |                 4 |                    5 |
| Mythr - My Friend       |                 2 |                    3 |
| Operation Diamond Raket |                 3 |                    4 |
+-------------------------+-------------------+----------------------+
4 rows in set (0.01 sec)


--5. Update rating of all movies directed by ‘Steven Spielberg’ to 5.	\c

update RATING set Review_Stars = 5 where Movie_ID in (select M.Movie_ID from MOVIE M, DIRECTOR D where D.Director_ID = M.Director_ID and Director_Name = 'Steven Spielberg');

--\c

