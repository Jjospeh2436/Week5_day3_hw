SELECT *
FROM order_;

SELECT *
FROM customer;

-- INNER JOIN
-- Give data that matchs in both tables
SELECT first_name, last_name, order_date, amount, customer.customer_id, order_id
FROM customer -- customer is Table A
INNER JOIN order_ -- order_ is Table B
ON customer.customer_id = order_.customer_id;

-- LEFT JOIN
SELECT first_name, last_name, amount
FROM customer
LEFT JOIN order_
ON customer.customer_id = order_.customer_id;

-- LEFT JOIN WHERE order_date is NOT NULL
SELECT first_name, last_name, order_date, amount
FROM customer
LEFT JOIN order_
ON customer.customer_id = order_.customer_id
WHERE order_date IS NOT NULL;

-- RIGHT JOIN
SELECT first_name, last_name, order_date, amount, order_id, customer.customer_id
FROM customer
RIGHT JOIN order_
ON customer.customer_id = order_.customer_id;

-- FULL JOIN
SELECT *
FROM customer
FULL JOIN order_
ON customer.customer_id = order_.customer_id;