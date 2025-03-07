-- SUMMARIZING AND CLEANING DATA IN SQL
/* OBJECTIVE
Identify dirty data and describe ways of cleaning it
Explain the DSP model and the use of the VIEW statement
Create a data profile of summary statistics using sql
*/

/* 1. Dirty data - lots of duplicates hence database is less reliable

1. Duplicate data
Two or more rows of data having the same values across board
Film_ID	Title	Rating	Rental_rate
1	The Matrix	PG-13	2.99
2	The Matrix	PG-13	2.99

2. Non-Uniform Data 
(Non-uniform data occurs when the same value is entered 
into the database in different formats) PG-13; PG-Thirteen; PG__13

3. Incorrect Data
Incorrect data is caused by typos and spelling variations, 
and is commonly found in address fields. e.g

777 Brockton Ave, Abington MA 2351
777 Brocktan Avenue, Abington MA 2351
777 Brockton Avenue, 2351

4. Missing Data
*/
-------------------------
1. Duplicate data
-------------------------
-- Handling Duplicate data ( You need to check for duplicates before cleaning data in sql)
SELECT col1,
       col2,
       col3 ...,
       count(*)
FROM tablename
GROUP BY col1,
         col2,
         col3, ...
HAVING COUNT(*) > 1


--Shows only those records that duplicate(based on columns selected)

SELECT title,
       release_year,
       language_id,
       rental_duration,
       COUNT(*)
FROM film
GROUP BY title,
         release_year,
         language_id,
         rental_duration
HAVING COUNT(*) >1; --no result set means we have no duplicates

-------------------------
-- CREATING A VIEW
-------------------------
-- Here is the SQL syntax for cleaning up duplicates using the methods outlined above.

Option 1: Creating a View with Unique Records

CREATE VIEW viewname AS
SELECT col1,
       col2,
       col3 ...
FROM tablename
GROUP BY col1,
         col2,
         col3, ... --Group by will make each row unique

Option 2: Deleting the Duplicate Record
DELETE
FROM tablename
WHERE unique_id NOT IN
    (SELECT MIN(unique_id)
     FROM tablename
     GROUP BY col1,
              col2,
              col3, ...)


--Shows only unique records from the film table

SELECT title,
       release_year,
       language_id,
       rental_duration
FROM film
GROUP BY title,
         release_year,
         language_id,
         rental_duration;

Here is the SQL syntax for selecting unique records with DISTINCT:

SELECT DISTINCT title,
                release_year,
                language_id,
                rental_duration
FROM film;

-------------------------
Non-Uniform Data
-------------------------
-- You can use the GROUP BY and DISTINCT to know the Non-Uniform Data in SQL

Rating
PG-13
NC-17
R
PG
G
gen
g
General


You need to update the values that represent a “G” rating to be consistent.
UPDATE film
SET rating = 'G'
WHERE rating IN ('gen',
                 'g',
                 'General')

----------------
Incorrect Data
----------------
You can use UPDATE when you get incorrect data. e.g 456 in age or -28

----------------
Missing Data
----------------
- You can ignore the missing columns
- Input using statistical method (e.g Mean or Average)

--imputing missing values with the AVG value
UPDATE tablename
SET = AVG(col1)
WHERE col1 IS NULL

					---------------------------
					Summarizing the Data
					---------------------------
-- DESCRIPTIVE STATISTICS
SELECT MIN(rental_rate) AS min_rent,
       MAX(rental_rate) AS max_rent,
       AVG(rental_rate) AS avg_rent,
       COUNT(rental_rate) AS count_rent_values,
       COUNT(*) AS count_rows
FROM film;

/*It only makes sense to use the 
aggregate functions MAX, MIN, and AVG with numerical or date/time values.
*/

-- FOR non numeric column, use other statistics like MODE (Most occured value)

SELECT MODE() WITHIN GROUP (ORDER BY rating)
       AS modal_value
FROM film;

--From above, the majority of movies in the Rockbuster collection have a PG-13 rating.

-- Another way to summarize it is 
SELECT rating,
       COUNT(*)
FROM film
GROUP BY rating
ORDER BY COUNT(*);

-- Development, Staging, and Production (DSP) Model

-----------------
USING VIEWS
-----------------

Views in SQL are virtual tables created by a query. 
They provide several benefits that enhance database management and usability.

-- Why views
- Security
- Readability
- Query Optimization
- Reusability

If you need to create views for US and China specific movies: 

CREATE VIEW  film_english_view AS
SELECT * FROM film
WHERE language_id = 1 -- English Language code is 1;

CREATE VIEW  film_cantonese_view AS
SELECT * FROM film
WHERE language_id = 2 -- Cantonese Language code is 2;

-- You can write a select statement on the view
SELECT * FROM film_english_view

Read more on views: https://www.c-sharpcorner.com/UploadFile/f0b2ed/views-in-sql-server/

