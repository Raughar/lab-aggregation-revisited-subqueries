USE sakila;

-- Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT DISTINCT c.first_name, c.last_name, c.email
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id;

-- What is the average payment made by each customer
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, AVG(p.amount) AS average_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name;

-- Select the name and email address of all the customers who have rented the "Action" movies using multiple joins first:
SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Action';

-- Now, the same but using where statements:
SELECT first_name, last_name, email
FROM customer
WHERE
    customer_id IN (
        SELECT DISTINCT c.customer_id
        FROM customer c
        JOIN rental r ON c.customer_id = r.customer_id
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN film f ON i.film_id = f.film_id
        JOIN film_category fc ON f.film_id = fc.film_id
        JOIN category cat ON fc.category_id = cat.category_id
        WHERE cat.name = 'Action'
    );
-- The two queries have the same results.alter

-- Create a new column using the CASE statement, calssifiying existing columns as high value or low value:
SELECT payment_id, customer_id, amount,
    CASE
        WHEN amount BETWEEN 0 AND 2 THEN 'Low'
        WHEN amount BETWEEN 2 AND 4 THEN 'Medium'
        WHEN amount > 4 THEN 'High'
        ELSE 'Unknown'
    END AS transaction_class
FROM payment;
