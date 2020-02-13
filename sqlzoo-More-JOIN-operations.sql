/* List the films where the yr is 1962 [Show id, title]  */

SELECT id, title
 FROM movie
 WHERE yr=1962
 
 
/* Give year of 'Citizen Kane'.  */

SELECT yr
 FROM movie
 WHERE title='Citizen Kane'
 
 
/* List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. */

SELECT id, title, yr
 FROM movie
 WHERE title LIKE '%Star Trek%'
 ORDER BY yr
 
 
 /* What id number does the actor 'Glenn Close' have?  */
 
SELECT id
FROM actor
WHERE name = 'Glenn Close'


/* What is the id of the film 'Casablanca' */

SELECT id
FROM movie
WHERE title = 'Casablanca'


/* Obtain the cast list for 'Casablanca'. what is a cast list? Use movieid=11768, (or whatever value you got from the previous question) */

SELECT c.actor_name
FROM (SELECT a.movieid, a.actorid, b.id, b.name AS actor_name
FROM casting AS a
JOIN actor AS b
ON a.actorid = b.id
WHERE a.movieid=11768) AS c


/* Obtain the cast list for the film 'Alien' */

SELECT d.actor_name
FROM (SELECT a.movieid, a.actorid, b.id, b.name AS actor_name, c.id AS movie_id, c.title
FROM casting AS a
JOIN actor AS b
ON a.actorid = b.id
JOIN movie as c
ON a.movieid = c.id

      
/* List the films in which 'Harrison Ford' has appeared */
      
SELECT d.movie_title
FROM (SELECT a.movieid, a.actorid, b.id, b.name AS actor_name, c.id AS movie_id, c.title AS movie_title
FROM casting AS a
JOIN actor AS b
ON a.actorid = b.id
JOIN movie as c
ON a.movieid = c.id
WHERE b.name = 'Harrison Ford') AS d

/* List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] */
      
SELECT d.movie_title
FROM (SELECT a.movieid, a.actorid, a.ord, b.id, b.name AS actor_name, c.id AS movie_id, c.title AS movie_title
FROM casting AS a
JOIN actor AS b
ON a.actorid = b.id
JOIN movie as c
ON a.movieid = c.id
WHERE b.name = 'Harrison Ford' AND a.ord > 1) AS d


/* List the films together with the leading star for all 1962 films. */
      
SELECT d.movie_title, d.actor_name
FROM (SELECT a.movieid, a.actorid, a.ord, b.id, b.name AS actor_name, c.id AS movie_id, c.title AS movie_title
FROM casting AS a
JOIN actor AS b
ON a.actorid = b.id
JOIN movie as c
ON a.movieid = c.id
WHERE c.yr = 1962 AND a.ord = 1) AS d


/* Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies. */

SELECT a.yr,COUNT(a.title) FROM
  movie AS a JOIN casting AS b ON a.id=b.movieid
        JOIN actor AS c ON b.actorid=c.id
WHERE c.name='Rock Hudson'
GROUP BY a.yr
HAVING COUNT(a.title) > 2
ORDER BY COUNT(a.title) desc
      

/* List the film title and the leading actor for all of the films 'Julie Andrews' played in. */
      
SELECT title, name
FROM movie JOIN casting ON (movieid=movie.id AND ord=1)
JOIN actor ON (actorid=actor.id)
WHERE movie.id IN(
SELECT movieid FROM casting
WHERE actorid IN (
  SELECT id FROM actor
  WHERE name='Julie Andrews'))
 
 
/* Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles. */
 
SELECT d.actor_name 
FROM (SELECT a.movieid, a.actorid, a.ord, b.id, b.name AS actor_name, c.id AS movie_id, c.title AS movie_title
FROM casting AS a
JOIN actor AS b
ON a.actorid = b.id
JOIN movie as c
ON a.movieid = c.id
WHERE a.ord = 1) AS d
GROUP BY d.actor_name
HAVING COUNT(d.movie_title) > 14
ORDER BY d.actor_name
 

/* List the films released in the year 1978 ordered by the number of actors in the cast, then by title. */
 
SELECT d.movie_title, COUNT(d.actor_name)
FROM (SELECT a.movieid, a.actorid, a.ord, b.id, b.name AS actor_name, c.id AS movie_id, c.title AS movie_title
FROM casting AS a
JOIN actor AS b
ON a.actorid = b.id
JOIN movie as c
ON a.movieid = c.id
WHERE c.yr = 1978) AS d
GROUP BY d.movie_title
ORDER BY COUNT(d.actor_name) DESC, d.movie_title


/* List all the people who have worked with 'Art Garfunkel'. */
 
SELECT a.name
FROM actor AS a JOIN casting AS b ON a.id=b.actorid
WHERE b.movieid IN (SELECT movieid FROM casting WHERE actorid IN (SELECT id
FROM actor
WHERE name = 'Art Garfunkel')) AND a.name NOT IN ('Art Garfunkel')
                                                                  
