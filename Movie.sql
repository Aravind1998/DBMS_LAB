--Creation and Insertion Statements for Movie Database	\c

create database MovieDB;

use MovieDB;

create table ACTOR(Actor_ID int, Actor_Name varchar(10), Gender varchar(6), Primary Key (Actor_ID));

create table DIRECTOR(Director_ID int, Director_Name varchar(30), Phone varchar(10), Primary Key (Director_ID));

create table MOVIE(Movie_ID int, Movie_Title varchar(30), Year int, Language varchar(10), Director_ID int, Primary Key (Movie_ID), Foreign Key (Director_ID) references DIRECTOR(Director_ID));

create table MOVIE_CAST(Actor_ID int, Movie_ID int, Role varchar(10), Primary Key (Actor_ID, Movie_ID), Foreign Key (Actor_ID) references ACTOR(Actor_ID), Foreign Key (Movie_ID) references MOVIE(Movie_ID));

create table RATING(Movie_ID int, Review_Stars int, Primary Key (Movie_ID, Review_Stars), Foreign Key (Movie_ID) references MOVIE(Movie_ID));

insert into ACTOR values
(1, 'Rajkumar', 'Male'),
(2, 'Sudeep', 'Male'),
(3, 'Suhasini', 'Female'),
(4, 'Shankarnag', 'Male'),
(5, 'Samanta', 'Female'),
(6, 'Revathi', 'Female');

insert into DIRECTOR values
(11, 'Putanna Kanagal', '9876543212'),
(22, 'Rajan Nagendra', '9876543215'),
(33, 'Nagathihalli Chandrashekar', '9876543214'),
(44, 'Hitchcock', '9876543216'),
(55, 'Steven Spielberg', '9876543217');

insert into MOVIE values
(12, 'Operation Diamond Raket', 2000, 'Kannada', 11),
(13, 'Mythr - My Friend', 2011, 'English', 44),
(14, 'Malgudi Days', 1995, 'English', 55),
(15, 'Ehega', 2016, 'Telugu', 33),
(16, 'Mummy', 2000, 'English', 55);

insert into MOVIE_CAST values
(1, 12, 'Hero'),
(3, 12, 'Heroine'),
(6, 13, 'Heroine'),
(4, 14, 'Hero'),
(4, 15, 'Villain'),
(5, 14, 'Heroine'),
(2, 15, 'Hero'),
(3, 16, 'Heroine');

insert into RATING values
(12, 3),
(12, 4),
(12, 1),
(13, 2),
(13, 3),
(14, 4),
(14, 2),
(14, 1),
(14, 5),
(15, 3),
(15, 2);

