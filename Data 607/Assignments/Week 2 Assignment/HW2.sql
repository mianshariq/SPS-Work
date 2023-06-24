drop table if exists ratings;
drop table if exists movies;

CREATE TABLE movies(
id INT primary key,
name_movie VARCHAR(255),
director VARCHAR(255),
year_released INT,
movie_length TIME);

INSERT INTO movies(id, name_movie, director, year_released, movie_length)
VALUES(001, "Inception", "Christopher Nolan", "2010", "02:28:00"),
    (002, "The Intouchables", "Olivier Nakache", "2011", "01:52:00"),
    (003, "3 Idiots", "Rajkumar Hirani", "2009", "02:51:00"),
    (004, "Ip Man", "Wilson Yip", "2010", "01:46:00"),
    (005, "Toy Story", "John Lasseter", "1995", "01:21:00");

select * from movies;


CREATE TABLE ratings(
reviewer_id INT primary key,
user_name VARCHAR(255),
movie_id INT,
rating INT,
review varchar(255),
FOREIGN KEY (movie_id) REFERENCES movies(id));

INSERT INTO ratings(reviewer_id, user_name, movie_id, rating, review)
VALUES(1001, "laibah", 001, 5, "Great movie"),
    (1002, "laibah", 002, 5, "Amazing"),
    (1003, "laibah", 003, NULL, NULL),
    (1004, "laibah", 004, NULL, NULL),
    (1005, "laibah", 005, 4, "Great movie"),
    (1006, "maria", 001, 5, "It was great"),
    (1007, "maria", 002, 5, "It was amazing"),
    (1008, "maria", 003, 5, "so funny"),
    (1009, "maria", 004, NULL, NULL),
    (1010, "maria", 005, 5, "classic"),
    (1011, "abrahim", 001, 5, "It was good"),
	(1012, "abrahim", 002, 3, "It was ok"),
	(1013, "abrahim", 003, 5, "funny"),
	(1014, "abrahim", 004, 3, "ok"),
	(1015, "abrahim", 005, 3, "It was ok"),
    (1016, "sarah", 001, 5, "Cool"),
    (1017, "sarah", 002, NULL, NULL),
    (1018, "sarah", 003, 5, "Nice"),
    (1019, "sarah", 004, 2, "could be better"),
    (1020, "sarah", 005, 3, "Cool"),
    (1021, "Mariam", 001, 3, "ok"),
    (1022, "Mariam", 002, NULL, NULL),
    (1023, "Mariam", 003, NULL, NULL),
    (1024, "Mariam", 004, NULL,NULL),
    (1025, "Mariam", 005, 5, "good");

select *
from movies
left join ratings
on movies.id=ratings.movie_id;

select joined.id, joined.name_movie, avg(joined.rating) AS Average_Rating, count(rating) AS Number_of_Reviews from (select id, name_movie, director, rating, user_name, review 
from movies
left join ratings
on movies.id=ratings.movie_id) as joined
group by name_movie;