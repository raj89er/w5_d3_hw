-- Syntax Order -- (SELECT and FROM are the only mandatory clauses)

-- SELECT (column_names)
-- FROM (table_name)
-- WHERE (row filter)
-- GROUP BY (aggregations)
-- HAVING (filter aggregations)
-- ORDER BY (column_value ASC or DESC)
-- OFFSET (number of rows to skip)
-- LIMIT (max number of rows to display)


--1. List all customers with their address who live in Texas (use JOINs)

SELECT c.first_name, c.last_name, a.address, a.district
FROM customer c
JOIN address a
ON c.address_id = a.address_id
WHERE a.district = 'Texas';

-- see temp table for the 5 people


--2. List all payments of more than $7.00 with the customer’s first and last name

SELECT c.first_name, c.last_name, p.amount
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id 
WHERE p.amount > 7;

-- see temp table for the emourmous list


-- 3. Show all customer names who have made over $175 in payments (use subqueries)

SELECT search1.first_name, search1.last_name, total_payments
FROM (
	SELECT c.first_name, c.last_name, SUM(p.amount) AS total_payments
	FROM customer c
	JOIN payment p 
	ON c.customer_id = p.customer_id
	GROUP BY c.customer_id, c.first_name, c.last_name
) AS search1
WHERE search1.total_payments > 175;

-- this took too long to figure out that i need to use 'search1.first_name' in line 37
-- please see temp table for the 6 names


-- 4. List all customers that live in Argentina (use multiple joins)

SELECT c.first_name, c.last_name
FROM customer c
JOIN address a
ON c.address_id = a.address_id
JOIN city c2 
ON a.city_id = c2.city_id 
JOIN country c3 
ON c2.country_id = c3.country_id 
WHERE c3.country = 'Argentina';

-- see temp list below for the list of 12 people


-- 5. Show all the film categories with their count in descending order

SELECT category.name as category , COUNT(film_category.category_id) as amount_of_films
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY COUNT(film_category.category_id) DESC;


-- 6. What film had the most actors in it (show film info)?

SELECT f.title, COUNT(fa.actor_id) AS "actor count", f.description 
FROM film f
JOIN film_actor fa 
ON f.film_id = fa.film_id 
JOIN actor a 
ON fa.actor_id = a.actor_id
GROUP BY f.title, f.description 
ORDER BY "actor count" DESC
LIMIT 1
;

-- Lambs Cincinatti wins with 1 actors


-- 7. Which actor has been in the least movies?

SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS "Movie count"
FROM actor a
JOIN film_actor fa 
ON a.actor_id = fa.actor_id 
JOIN film f 
ON fa.film_id = f.film_id 
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY "Movie count" ASC ;

-- Emily Dee was only in 14 films


-- 8. Which country has the most cities?

SELECT co.country, COUNT(ci.city_id) as city_count
FROM country co
JOIN city ci
ON co.country_id = ci.country_id
GROUP BY co.country 
ORDER BY city_count DESC
;

-- India has 60 cities in the table


-- 9. List the actors who have been in between 20 and 25 films.

SELECT a.first_name, a.last_name, COUNT(fa.film_id)
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY a.first_name, a.last_name
HAVING COUNT(fa.film_id) BETWEEN 20 AND 25
;

-- see large table below
-- we can't alias the "COUNT(fa.film_id)" in line 121 to use in line 126?





























