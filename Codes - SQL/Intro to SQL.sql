-- Training Class 

-- Count all the actors whose first name is “Ed.” Write down the result in a text document.
SELECT COUNT(*)
   FROM actor
   WHERE first_name = 'Ed'

-- list the names of the columns in the payment table.
 SELECT * FROM payment LIMIT 10;


 -- What are the names of the tables that are available in the Rockbuster database? (List all names.)

  SELECT * FROM information_schema.tables
   WHERE table_schema = 'public'
   AND table_type = 'BASE TABLE'

 -- Analyze the rental duration distribution. How many days are most films rented for?
    SELECT rental_duration AS "rented for (in days)", COUNT(*) AS "number of films"
   FROM film
   GROUP BY 1
   ORDER BY 2

