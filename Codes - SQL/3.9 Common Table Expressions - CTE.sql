---------------------------------------
-- 3.9: COMMON TABLES EXPRESSION (CTEs)
---------------------------------------
--Note - CTRL + SHIFT + F = SQL Query Format
/*
Explain how CTEs are used
Differentiate between a subquery and a CTE
Rewrite subqueries as CTEs
*/


--WITH CTE_NAME AS 
--(
--SELECT STATEMENT
--)

-- CTE
WITH millions AS 
(SELECT customer_id
	FROM rental
	WHERE return_date < '2005-07-29')
	
SELECT *
FROM customer c
JOIN millions ON millions.customer_id = c.customer_id ;

-- SUbquery
SELECT *
FROM customer
WHERE customer_id IN 
	(SELECT customer_id 
	FROM rental
	WHERE return_date < '2005-07-29');



A common table expression (CTE) is a temporary table you can reference in the main query that follows it.
SIMILAR TO subqueries but MORE optimized. It IS written AT the START OF the main query. 

--Que
The inventory team at Rockbuster wants a list of ratings for each film category in the 
Rockbuster database, including how many times each rating occurs.

rating	category	count
R	Thriller		10
R	Comedy			9
...	…	….
PG-13	Crime		7

- Step 1. Confirm OR locate the TABLES you need fro ERD OR DATA DICTIONARY 
This will INCLUDE ALL joins needed FOR the query


- Step 2
GET a list OF film categories AND ratings

SELECT 
	f.film_id,
	f.rating,
	c.name AS category
FROM film f 
LEFT JOIN film_category fc ON fc.film_id = f.film_id 
LEFT JOIN category c ON c.category_id = fc.category_id 

Step 3: wrap the above IN  a CTE 

WITH category_name_CTE AS 
(
SELECT 
		f.film_id,
		f.rating,
		c.name AS category
FROM
	film f
LEFT JOIN film_category fc ON
	fc.film_id = f.film_id
LEFT JOIN category c ON
	c.category_id = fc.category_id 	
)

SELECT
	rating,
	category,
	COUNT(film_id) AS cnts
FROM category_name_CTE
GROUP BY 1, 2
ORDER BY cnts DESC;

--SELECT f.film_id,
--       f.rating,
--       c.name
--FROM film f 
--LEFT JOIN film_category fc ON f.film_id = fc.film_id
--LEFT JOIN category c ON fc.category_id = c.category_id


Step 3: Define a CTE

WITH categry_name_CTE (film_id, rating, category_name) AS
	(SELECT f.film_id,
	       f.rating,
	       c.name
	FROM film f 
	LEFT JOIN film_category fc ON f.film_id = fc.film_id
	LEFT JOIN category c ON fc.category_id = c.category_id)

--Step 4: WRITE main Query
-- Count how many times the various ratings occur in each film category
WITH categry_name_CTE (film_id, rating, category_name) AS
	(SELECT f.film_id,
	       f.rating,
	       c.name
	FROM film f 
	LEFT JOIN film_category fc ON f.film_id = fc.film_id
	LEFT JOIN category c ON fc.category_id = c.category_id)

SELECT  
	rating, 
	category_name,
	COUNT(film_id) AS filmcounts
FROM categry_name_CTE
GROUP BY 1, 2
ORDER BY rating, 
		filmcounts DESC;

-----------------------
CTE OR SUBQUERY?
-----------------------
SELECT rating,
       name AS category_name,
       COUNT(film_id) AS cnts
FROM
  (SELECT A.film_id,
          A.rating,
          C.name
   FROM film A
   LEFT JOIN film_category B ON A.film_id = B.film_id
   LEFT JOIN category C ON B.category_id = C.category_id) AS category_name_sub
GROUP BY 1,
         2
ORDER BY rating,
         cnts DESC


         
-- CHECK WITH EXPLAIN
         
--EXPLAIN FOR CTE
EXPLAIN ANALYZE
WITH categry_name_CTE (film_id, rating, category_name) AS
	(SELECT f.film_id,
	       f.rating,
	       c.name
	FROM film f 
	LEFT JOIN film_category fc ON f.film_id = fc.film_id
	LEFT JOIN category c ON fc.category_id = c.category_id)
SELECT  
	rating, 
	category_name,
	COUNT(film_id) AS filmcounts
FROM categry_name_CTE
GROUP BY 1, 2
ORDER BY rating, 
		filmcounts DESC;


 -- EXPLAIN FOR SUBQUERY        
EXPLAIN  ANALYZE    
SELECT rating,
       name AS category_name,
       COUNT(film_id) AS cnts
FROM
  (SELECT A.film_id,
          A.rating,
          C.name
   FROM film A
   LEFT JOIN film_category B ON A.film_id = B.film_id
   LEFT JOIN category C ON B.category_id = C.category_id) AS category_name_sub
GROUP BY 1,
         2
ORDER BY rating,
         cnts DESC;


--EXPLAIN FOR CTE
EXPLAIN
WITH categry_name_CTE (film_id, rating, category_name) AS
	(SELECT f.film_id,
	       f.rating,
	       c.name
	FROM film f 
	LEFT JOIN film_category fc ON f.film_id = fc.film_id
	LEFT JOIN category c ON fc.category_id = c.category_id)
SELECT  
	rating, 
	category_name,
	COUNT(film_id) AS filmcounts
FROM categry_name_CTE
GROUP BY 1, 2
ORDER BY rating, 
		filmcounts DESC;


 -- EXPLAIN FOR SUBQUERY        
EXPLAIN    
SELECT rating,
       name AS category_name,
       COUNT(film_id) AS cnts
FROM
  (SELECT A.film_id,
          A.rating,
          C.name
   FROM film A
   LEFT JOIN film_category B ON A.film_id = B.film_id
   LEFT JOIN category C ON B.category_id = C.category_id) AS category_name_sub
GROUP BY 1,
         2
ORDER BY rating,
         cnts DESC;

 
 /*
 
 1. Accessibility: As a Data analyst, you may not have permission to create or delete tables in your company database. 
 In this case, a CTE is quite handy because it lets you create a temporary table with the necessary information. 
 Think of it a bit like creating a VIEW.

2. Readability: When using a CTE, you define everything from the outset. 
You create a temporary table and give it a name, 
then refer to this temporary table name as you write your main query. 
Your code is, therefore, much easier to read compared to a subquery. 
This may not seem like such a big deal if the queries are only a few lines long. 
When you start working with an actual production database, 
however, you’ll see just how long and complex SQL queries can become, and you’ll begin to 
understand why CTEs make life so much easier.

3. Performance: Don’t assume that a CTE will perform better than a subquery (by perform, we mean how fast it runs). 
The only way to find out which is faster is to write a CTE and a subquery that will achieve the same results, 
then compare the cost using EXPLAIN. If one of your queries has a significantly lower cost, use that one.
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */