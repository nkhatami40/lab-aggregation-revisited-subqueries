USE sakila;
#1- Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT distinct(first_name), last_name, email FROM rental 
left join customer using(customer_id);

SELECT first_name, last_name, email FROM customer; #It looks like all the customers have rented a movie.

#2- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT customer_id, avg(amount) as 'average_amount', CONCAT(first_name, ', ', last_name) AS 'name' 
FROM payment
join customer
using(customer_id)
GROUP BY customer_id, name;

#3-Select the name and email address of all the customers who have rented the "Action" movies.
#Write the query using multiple join statements
#Write the query using sub queries with multiple WHERE clause and IN condition
#Verify if the above two queries produce the same results or not

#Using join
SELECT first_name, last_name, email, ca.name FROM
customer c join rental r using(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film_category f USING(film_id)
JOIN category ca USING(category_id)
WHERE ca.name = 'Action';

SELECT * FROM
customer c join rental r using(customer_id);

SELECT * FROM
customer c join rental r using(customer_id)
JOIN inventory i USING(inventory_id);

SELECT first_name, last_name, email, ca.name FROM
customer c join rental r using(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film_category f USING(film_id)
JOIN category ca USING(category_id);

#Using subqueries:
SELECT first_name, last_name, email from customer c
where c.customer_id IN (SELECT customer_id from rental
where inventory_id IN (SELECT inventory_id from inventory
where film_id IN (SELECT film_id from film_category 
where category_id IN (SELECT category_id from category where category.name = 'Action'))));

#The results aren't the same as every row has different number of duplicates using the join.

#4- Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
#If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, 
#the label should be medium, and if it is more than 4, then it should be high.

SELECT amount, customer_id,
CASE 
	WHEN amount between 0 and 2 THEN 'low'
    WHEN amount between 2 and 4 THEN 'medium'
    WHEN amount>= 4 THEN 'high'
END AS 'transactions'
FROM payment;

