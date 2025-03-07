-- Select all films
SELECT * FROM public.film;

-- select 20 films
SELECT * FROM public.film
LIMIT 20;

-- SELECT SPECIFIC FIELD OR COLUMN WITH A COMMA
SELECT 
	title,
	release_year
FROM public.film
LIMIT 50;


SELECT * FROM film
WHERE film_id = 30;
-- WHERE IS USED TO FILTER 

