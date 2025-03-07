-- 3.10 - Presenting SQL Results

-- Exploratory Data Analysis (EDA)

Valuable , actionable insights WITHIN your DATA
profile the data
missing VALUES 
patterns

--Answering Business Questions
ERD 
DATA Dictionary


1. why analyzing 
2. what you did 
3. How did you arraive AT your findings
4. DO your findings challange OR VALIDATE anything 
5. what ACTION DO your findings trigers
6. Recommendations


1. Technical colleagues 
2. Managers OR Stakeholders OR Operation specialist

/*
Step 1
Use ERD TO find TABLES

Step 2
WRITE your query 

Step 3
Execute your query WITHIN SQL 

Step 4
Either export to csv or excel then connect visualization tools with the exported data
*/

-- Question: Find the CURRENT Geographical distribution OF customers AND the revenue GENERATED IN EACH country

SELECT 
	c3.country,
	COUNT(DISTINCT c.customer_id) AS No_of_Customers,
	sum(p.amount) AS total_payment
FROM customer c 
INNER JOIN payment p ON p.customer_id = c.customer_id 
INNER JOIN address a ON a.address_id = c.address_id 
INNER JOIN city c2 ON c2.city_id = a.city_id 
INNER JOIN country c3 ON c3.country_id = c2.country_id 
GROUP BY c3.country
ORDER BY No_of_Customers DESC;


CREATE a VIEW TO be consumed BY power BI

CREATE VIEW vvcustomerdistribution AS 
SELECT 
	c3.country,
	COUNT(DISTINCT c.customer_id) AS No_of_Customers,
	sum(p.amount) AS total_payment
FROM customer c 
INNER JOIN payment p ON p.customer_id = c.customer_id 
INNER JOIN address a ON a.address_id = c.address_id 
INNER JOIN city c2 ON c2.city_id = a.city_id 
INNER JOIN country c3 ON c3.country_id = c2.country_id 
GROUP BY c3.country
ORDER BY No_of_Customers DESC;

SELECT 
*
FROM vvcustomerdistribution v 





country,
count OF customers

SELECT 
	country, 
	CITY,
	count(customer id) AS no_of_customers,
	COUNT(COUNTRY) AS COUNTRYCOUNT
FROM TABLE
JOIN Several TABLES IF necessary
GROUP BY COUNTRY, CITY



customer , 
address,
city,
country ,
payment
