--  Week 5 - Wednesday Questions

-- 1. List all customers who live in Texas (use JOINs)


SELECT customer.customer_id,customer.first_name, customer.last_name, address.district
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas'; 

Answer : 
"customer_id","first_name","last_name","district"
6,"Jennifer","Davis","Texas"
118,"Kim","Cruz","Texas"
305,"Richard","Mccrary","Texas"
400,"Bryan","Hardison","Texas"
561,"Ian","Still","Texas"




--2. Get all payments above $6.99 with the Customer's Full Name;

-- SELECT customer.customer_id, customer.first_name, customer.last_name, payment.amount
-- FROM customer
-- JOIN payment
-- ON customer.customer_id = payment.customer_id
-- WHERE payment.amount > 6.99;


SELECT customer.customer_id, (customer.first_name || ' ' || customer.last_name) AS customer_full_name, payment.amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99;


Answer : This query has a response of 1423 records. 
        

--3. Show all customers names who have made payments over $175(use subqueries)

SELECT  distinct customer.customer_id , customer.first_name, customer.last_name
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IN (select customer_id from payment group by customer_id having sum(amount) >175)

Answer : 
"customer_id","first_name","last_name"
137,"Rhonda","Kennedy"
459,"Tommy","Collazo"
341,"Peter","Menard"
178,"Marion","Snyder"
144,"Clara","Shaw"
148,"Eleanor","Hunt"
526,"Karl","Seal"



-- 4. List all customers that live in Nepal (use the city table)

SELECT customer.customer_id, (customer.first_name || ' ' || customer.last_name) AS customer_full_name
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country 
ON city.country_id = country.country_id
WHERE city.country_id = (SELECT country_id FROM country WHERE country = 'Nepal')

Answer : 
"customer_id","customer_full_name"
321,"Kevin Schuler"


-- 5. Which staff member had the most transactions?

SELECT staff.staff_id, count(rental.rental_id) as total_transactions
FROM staff
JOIN rental
ON staff.staff_id = rental.staff_id
GROUP BY staff.staff_id
ORDER BY total_transactions DESC
LIMIT 1; 

Answer : 
"staff_id","total_transactions"
1,"8040"


-- 6. How many movies of each rating are there?




SELECT  rating, COUNT(film_id) AS movie_count
FROM film
GROUP BY rating;

Answer : 
"rating","movie_count"
"PG-13","223"
"G","178"
"R","195"
"NC-17","210"
"PG","194"


-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

-- created a TEMP TABLE with customer_id, where amount is more than 6.99 and 
--used those table data in another query. This is the only solution I came up 
--to find the customers who have made "only one" transaction above 6.99

SELECT
    customer_id,
    amount 
INTO TEMP TABLE above_seven
FROM
    payment
WHERE
    amount>6.99
ORDER BY
    customer_id;

select customer_id, count(customer_id)
from above_seven
group by customer_id
having count(customer_id)=1
order by customer_id;

Answer : 

130 customers have made a SINGLE PAYMENT above 6.99


--  8. How many free rentals did our stores give away?


SELECT COUNT(rental.rental_id)
FROM rental
JOIN payment
ON rental.rental_id = payment.rental_id
WHERE payment.amount = 0;

Answer : 24

-- Also can be done without join : 

-- select count(rental_id) from payment where amount = 0;

