SELECT *
FROM staff;

SELECT *
FROM rental;

SELECT first_name, last_name, staff.staff_id, COUNT(staff.staff_id)
FROM staff
FULL JOIN rental
ON staff.staff_id = rental.staff_id
WHERE staff.staff_id IS NOT NULL
GROUP BY staff.staff_id;

SELECT *
FROM actor;

SELECT *
FROM film;

SELECT *
FROM film_actor;


-- Query for film_id's from the film_actor table and which actors appear witht hose film_id's
SELECT actor.actor_id, first_name, last_name, film_id
FROM actor
INNER JOIN film_actor
ON  actor.actor_id = film_actor.actor_id;

--Query to see which actors are in what films
SELECT first_name, last_name, title, description, actor.actor_id, film.film_id
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id;


-- LEFT JOIN on the actor Table and film_actor
SELECT actor.actor_id, first_name, last_name, film_id
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE first_name IS NULL AND last_name IS NULL;

-- Find all customers who live in the country of Angola
SELECT COUNT(customer_id), first_name, last_name, country, customer.address_id, address.city_id, city.country_id
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola'
GROUP BY first_name, last_name, country, customer.address_id, address.city_id, city.country_id;

-- SubQueries Query within a Query
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC; 

SELECT store_id, first_name, last_name, customer_id
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

-- Query for customers who live in the US and have made a total amount of payments over 175
SELECT first_name, last_name, address
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'United States' AND customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);

-- Subquery within the same table
-- Query for amounts paid greater than the average amount paid
SELECT AVG(amount)::NUMERIC(6, 2)
FROM payment;

SELECT payment_id, amount
FROM payment
WHERE amount > 4.30;

-- Subquery to find amounts paid greaeter than the average amount paid
SELECT payment_id, amount
FROM payment
WHERE amount > (
	SELECT AVG(amount)
	FROM payment
);

-- Subquery to find customers who live in Dallas
SELECT first_name, last_name, address_id
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE city = 'Dallas'
	)
);

-- Query for all actions movies
SELECT title, film_id
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_category
	WHERE category_id IN (
		SELECT category_id
		FROM category
		WHERE name = 'Action'
	)
)
