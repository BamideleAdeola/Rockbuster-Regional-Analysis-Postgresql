-- Retrieving data from multiple tables 

SELECT 
	f.film_id,
	f.title,
	f.release_year,
	l.name AS language_name
FROM film f
INNER JOIN language l
ON l.language_id = f.language_id
LIMIT 5;


SELECT 
	a.film_id,
	a.title,
	a.release_year,
	b.name AS language_name
FROM film a
INNER JOIN language b
ON a.language_id = b.language_id
LIMIT 10;



-- pull payment id, customer id , amount , firstname and last name of customer, email

SELECT 
	p.payment_id ,
	p.customer_id ,
	p.amount ,
	c.first_name ,
	c.last_name ,
	c.email 
FROM payment p 
INNER JOIN customer c 
ON c.customer_id = p.customer_id;


-- pull payment id, customer id , amount , firstname and last name of customer, email using left join

SELECT 
	p.payment_id ,
	p.customer_id ,
	p.amount ,
	c.first_name ,
	c.last_name ,
	c.email 
FROM payment p 
LEFT JOIN customer c 
ON c.customer_id = p.customer_id;

-- RIGHT JOIN

SELECT 
	p.payment_id ,
	p.customer_id ,
	p.amount ,
	c.first_name ,
	c.last_name ,
	c.email 
FROM payment p 
RIGHT JOIN customer c 
ON c.customer_id = p.customer_id;


-- FULL OUTER JOIN

SELECT 
	p.payment_id ,
	p.customer_id ,
	p.amount ,
	c.first_name ,
	c.last_name ,
	c.email 
FROM payment p 
FULL JOIN customer c 
ON c.customer_id = p.customer_id;



-- Retrieve Staff and their country


SELECT 
	s.staff_id,
	s.first_name ,
	s.last_name ,
	c2.country 
FROM staff s 
INNER JOIN address a ON a.address_id = s.address_id 
INNER JOIN city c ON c.city_id = a.city_id 
INNER JOIN country c2 ON c2.country_id = c.country_id; 



-- Retrieve Staff and their country
SELECT 
	s.staff_id,
	c2.country 
FROM staff s 
INNER JOIN address a ON a.address_id = s.address_id 
INNER JOIN city c ON c.city_id = a.city_id 
INNER JOIN country c2 ON c2.country_id = c.country_id; 


JOIN syntax
WHERE and an operator
GROUP BY
ORDER BY with the function (DESC or ASC),
LIMIT

-- count the number of employees in each country

SELECT 
	c2.country,
	COUNT(s.staff_id)
FROM staff s 
INNER JOIN address a ON a.address_id = s.address_id 
INNER JOIN city c ON c.city_id = a.city_id 
INNER JOIN country c2 ON c2.country_id = c.country_id
GROUP BY c2.country; 

