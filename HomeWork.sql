--Question 1
SELECT COUNT(customer)
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

--Question 2
SELECT customer.customer_id, first_name, last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;

--Question 3
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);

--Question 4
SELECT customer.customer_id, first_name, last_name
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE country_id IN (
			SELECT country_id
			FROM country
			WHERE country = 'Nepal'
		)
	)
);

--Question 5
SELECT first_name, last_name, COUNT(payment_id)
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT(payment_id) DESC;

--Question 6
SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

--Question 7
SELECT DISTINCT(COUNT(customer_id))
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(payment_id) = 1 
);

--Question 8
SELECT COUNT(rental_id)
FROM rental
WHERE rental_id IN (
	SELECT rental_id
	FROM payment
	WHERE amount = 0
);