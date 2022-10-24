
-- Exercise 1 
SELECT *
FROM rental
WHERE customer_id = 459;

-- Exercise 2 --
SELECT *
FROM country
WHERE country = 'Switzerland';

-- Exercise 3
EXPLAIN
SELECT *
FROM rental
WHERE customer_id = 459;

EXPLAIN
SELECT *
FROM country
WHERE country = 'Switzerland';


-- Exercise 4
CREATE INDEX index_rental_customer_id
ON rental(customer_id);

-- Exercise 5
CREATE INDEX index_country
ON country(country);

-- Exercise 6.1
EXPLAIN
SELECT *
FROM rental
WHERE customer_id = 459;

-- Exercise 6.2
EXPLAIN
SELECT *
FROM country
WHERE country = 'Switzerland';

-- C: Exercise 1
SELECT count(*)
FROM staff, payment
WHERE staff.first_name = 'Mike'
		AND staff.staff_id = payment.staff_id;

-- C: Exercise 2
EXPLAIN
SELECT count(*)
FROM staff, payment
WHERE staff.first_name = 'Mike'
		AND staff.staff_id = payment.staff_id;
		