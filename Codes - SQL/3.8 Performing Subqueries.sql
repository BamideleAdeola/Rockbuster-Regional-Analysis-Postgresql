---------------------------------------
-- 3.8: Performing Subqueries
---------------------------------------
--Note - CTRL + SHIFT + F = SQL Query Format
/*
Explain the order of SQL query writing
Define subqueries and their various applications in SELECT commands
Write subqueries to answer complex business questions
*/

A subquery is a query that’s nested within another query

-- CORRECT ORDER (BODMAS)
1. SELECT
2. FROM
3. WHERE
4. GROUP BY
5. HAVING
6. ORDER BY
7. LIMIT

/*
Execution Steps:
FROM: Start with the employees table.
WHERE: Filter out rows where department_id is NULL.
GROUP BY: Group rows by department_id.
HAVING: Keep only groups where COUNT(employee_id) > 2.
SELECT: Retrieve department_id and the calculated employee_count.
ORDER BY: Sort the results by employee_count in descending order.
LIMIT: Return only the top 5 rows.
*/

2 + 5 * 2 + 6* 0 = 12

SELECT
	title,
	release_year,
	rating
FROM
	film
WHERE
	release_year = 2006
ORDER BY
	release_year DESC
LIMIT 10;


SELECT
	department_id,
	COUNT(employee_id) AS employee_count
FROM
	employees
WHERE
	department_id IS NOT NULL
GROUP BY
	department_id
HAVING
	COUNT(employee_id) > 2
ORDER BY
	employee_count DESC
LIMIT 5;

---------------------------------------
-- Subqueries: a Query within a Query
---------------------------------------
A subquery, also known as an inner statement, is a query that’s nested within another query, 
known as the outer statement.

The inner statement produces a temporary table, which the outer statement can then access.
 INNER STATEMENT runs FIRST
 
 CRUD
 
-- Using Subqueries
 Subqueries can be used in SELECT, INSERT, UPDATE, and DELETE statements. 
 Depending ON what you intend TO achieve, subqueries can be used WITHIN Focusing 
 - ON SELECT 
 - WHERE
 - FROM
 - JOIN
 
 ----------------------------------
 1. SUBQUERIES IN SELECT CLAUSE
 ----------------------------------
 Allows you to use the results of the subquery to create a new column in your data OUTPUT.
 
-- E.g Find the maximum amount paid FOR ANY movie IN the Rockbuster database
 -- Display title, rating, and release year of each movie, as well as the amount paid.
 Solution:
 1. find max amount paid IN Payment TABLE
 2. Display the amount WITH other columns required
 
-- 1. MAX AMOUNT PAID (outer statement)
 SELECT
	max(amount)
FROM
	payment p ;
 
--2. SELECT required COLUMNS
SELECT
	title,
		rating,
		release_year
FROM
	film f ;

--steo 3: combine the query

SELECT
	title,
		rating,
		release_year,
		(
	SELECT
		max(amount)
	FROM
		payment) AS max_amount
FROM
	film; 
-- the max ampunt for any film or movie in the rockbuster database is $11.99
 
 
 
 
-- Step 1: MAX amount paid (inner Statement)
SELECT
	MAX(amount)
FROM
	payment;
 
-- Step 2: Outer Statement
SELECT
	title,
	rating,
	release_year
FROM
	film;

Step 3: INNER IN SELECT clause
-- nOTE INNER CLAUSE MUST BE ENCLOSED IN PARENTHESIS AND GIVING A MORE DESCRIPTIVE NAME

SELECT
	title,
	rating,
	release_year,
	(
	SELECT
		MAX(amount)
	FROM
		payment ) AS Max_Amount_Paid
FROM
	film;
-- Max amount paid for any movie in the Rockbuster Database is $11.99 (Subquery)


 ----------------------------------
 2. SUBQUERIES IN WHERE CLAUSE
 ----------------------------------
 
This lets you filter the results of your outer statement based on the results of your inner STATEMENT.

 e.g
 -- Find movies whose rental rate is lower than the average payment made.
 
-- Step 1: AVERAGE Payment made (inner Statement)
 SELECT avg(amount)
 FROM payment;  -- $4.200

-- Step 2: Outer Statement
SELECT title,
       rating,
       release_year,
       rental_rate 
FROM film;


SELECT title,
       rating,
       release_year,
       rental_rate 
FROM film
WHERE rental_rate < ( SELECT avg(amount) FROM payment);



-- Step 3: COMBINED Statement
SELECT
	title,
	rating,
	release_year,
	rental_rate
FROM
	film
WHERE
	rental_rate < 
	(
	SELECT
		avg(amount)
	FROM
		payment);

 ----------------------------------
 3. SUBQUERIES IN FROM CLAUSE
 ----------------------------------
 
 SELECT rating, count(film_id) 
 FROM film
 WHERE rating IN ('G', 'PG', 'PG-13')
 AND length <= 100
 GROUP BY rating;
 
 The Rockbuster management team wants to know how many films are rated G, PG, or PG-13, 
 and how many films are less than OR EQUAL 100-minutes long. They want to see the results 
 grouped by rating. To get this information, let’s nest a subquery in the FROM clause.
 
Step 1: Inner Statement
A Query to filter out films whose length is less than or equal to 100 minutes:

 SELECT f.film_id,
       f.rating
FROM film f
WHERE f.length <=100;



--NEW TABLE 
SELECT f.film_id,
       f.rating
FROM film f
WHERE f.length <=100;

Step 2: Outer Statement


Then, write an outer statement to count the number of movies for each rating, 
filtered to the three relevant ratings

SELECT rating,
COUNT(film_ID) AS short_movie_count
FROM film
WHERE rating IN ('G', 'PG', 'PG-13')
GROUP BY rating;

STEP 3

SELECT shortmovies.rating,
COUNT(shortmovies.film_ID)
FROM 
		(SELECT f.film_id,
		       f.rating
		FROM film f
		WHERE f.length <=100) AS shortmovies
WHERE shortmovies.rating IN ('G', 'PG', 'PG-13')
GROUP BY shortmovies.rating;



Step 3: Combine the two queries (NESTED IN FROM clause)
SELECT
	shortmovies.rating,
	COUNT(shortmovies.film_id)
FROM (
 SELECT f.film_id,
       f.rating
FROM film f
WHERE f.length <=100
)AS shortmovies
WHERE  shortmovies.rating IN ('G', 'PG', 'PG-13')
GROUP BY shortmovies.rating;

/*
SELECT
	rating,
	COUNT(film_id)
FROM film
WHERE rating IN ('G', 'PG', 'PG-13')
AND length <= 100
GROUP BY rating; 
*/
 
--SUBQUERIES TREE AND POSITION
SELECT
	(SELECT
	FROM
	WHERE
	GROUP BY
	HAVING
--	ORDER BY
	LIMIT) AS sub_in_Select
FROM
	(SELECT
	FROM
	WHERE
	GROUP BY
	HAVING
--	ORDER BY
	LIMIT) AS sub_in_FROM	
WHERE
	(SELECT
	FROM
	WHERE
	GROUP BY
	HAVING
--	ORDER BY
	LIMIT) AS sub_in_WHERE
GROUP BY
HAVING
ORDER BY
LIMIT


--YOU CAN ALSO USE JOIN

--SELECT 
--	fm.rating,
--	count(shortmovies.film_id) 
--FROM film fm
--JOIN (
-- SELECT f.film_id,
--       f.rating
--FROM film f
--WHERE f.length <=100
--) AS shortmovies ON shortmovies.film_id = fm.film_id 
--WHERE  shortmovies.rating IN ('G', 'PG', 'PG-13')
--GROUP BY fm.rating;


SELECT 
	fm.rating,
	COUNT(shortmovs.film_id)
FROM film fm
JOIN (SELECT f.film_id,
       f.rating
FROM film f
WHERE f.length <=100) AS shortmovs ON fm.film_id = shortmovs.film_id
WHERE fm.rating IN ('G', 'PG', 'PG-13')
GROUP BY fm.rating;



--SUB QUERIES WITH JOIN

SELECT f.film_id,
       f.rating
FROM film f
WHERE f.length <=100;

Step 2: Outer Statement


SELECT film.rating,
COUNT(shortone.film_ID) AS short_movie_count
FROM film
JOIN 
	(
	SELECT f.film_id,
	       f.rating
	FROM film f
	WHERE f.length <=100
	) AS shortone ON shortone.film_id = film.film_id 
WHERE film.rating IN ('G', 'PG', 'PG-13')
GROUP BY film.rating;



-- Count DISTINCT no of customers 
-- (aggregate can also be used in subqueries)

SELECT count( DISTINCT customer_id )
FROM customer c 

SELECT count(DISTINCT c.customer_id )
FROM customer c; 


/*
How many films a particular actor/actress has been in
limited TO just 5?
*/

SELECT 
	a.actor_id ,
	a.first_name ,
	a.last_name ,
	COUNT(DISTINCT f.film_id) AS total_film_creds
FROM actor a 
JOIN film_actor fa ON fa.actor_id = a.actor_id 
JOIN film f  ON f.film_id = fa.film_id 
GROUP BY a.actor_id ,
	a.first_name ,
	a.last_name 
LIMIT 5;

--Explanation
SELECT 
	a.actor_id,
	a.first_name ,
	a.last_name,
	COUNT(DISTINCT f.film_id) AS film_creds
FROM actor a
JOIN film_actor fa ON fa.actor_id  = a.actor_id 
JOIN film f ON f.film_id = fa.film_id 
GROUP BY a.actor_id
LIMIT 5;

-- The above query can be a sub query but with a distinct name
(
SELECT 
	a.actor_id,
	a.first_name ,
	a.last_name,
	COUNT(DISTINCT f.film_id) AS film_creds
FROM actor a
JOIN film_actor fa ON fa.actor_id  = a.actor_id 
JOIN film f ON f.film_id = fa.film_id 
GROUP BY a.actor_id,a.first_name ,a.last_name
LIMIT 5
) AS total_actor_creds

-- Putting it together (How many movies a actor featured in a year)
SELECT 
	f.release_year ,
	a.first_name ,
	a.last_name ,
	f.film_id 
FROM film f
JOIN film_actor fa ON fa.film_id = f.film_id 
JOIN actor a  ON a.actor_id = fa.actor_id 
JOIN 
	(
		SELECT 
			a.actor_id,
			a.first_name ,
			a.last_name,
			COUNT(DISTINCT f.film_id) AS film_creds
		FROM actor a
		JOIN film_actor fa ON fa.actor_id  = a.actor_id 
		JOIN film f ON f.film_id = fa.film_id 
		GROUP BY a.actor_id,a.first_name ,a.last_name
		LIMIT 5								-- sub query
	) AS total_actor_creds ON a.actor_id = total_actor_creds.actor_id
GROUP BY f.release_year ,
	a.first_name ,
	a.last_name ,
	f.film_id ;


/*
Rules AND Best Practices
1. Subquery can be the cause OF slow queries
2. ALWAYS place it IN a parentheses.
3. Subqueries IN FROM clause requires an alias
4. ORDER BY clause can't be used in a subquery but can in main query
5. use IN within inner statement if it returned multiple values. 

-- e.g Retrieve every customers where retrun date is ealier than July 29,2025;
*/

SELECT *
FROM customer c 
WHERE customer_id IN 
		(
			SELECT customer_id 
			FROM rental
			WHERE return_date < '2005-07-29'
		);
		
SELECT c.*, millions.return_date
FROM customer c 
JOIN
		(
			SELECT customer_id, return_date 
			FROM rental
			WHERE return_date < '2005-07-29'
		) AS millions ON millions.customer_id = c.customer_id   ;
			
		
		


SELECT *
FROM customer
WHERE customer_id IN 
	(SELECT customer_id 
	FROM rental
	WHERE return_date < '2005-07-29');
