
USE sakila;
-- 1.	 Display the number of films (2)
/*
Select COUNT(film_id) AS "Total Number Of Films"
FROM film;
*/
-- 2.	Display the number of customers who are not active (3)
/*
SELECT COUNT(active) AS "Customers who are inactive"
from customer
Where active IS FALSE;
*/   
-- 3.	Display the number of customers per store (4)
/* 
SELECT store_id, COUNT(customer_Id) AS 'Total number of customer'
FROM customer
GROUP BY store_id
 */
-- 4.	Using payment table, produce this output: (7)
/* 
SELECT COUNT(payment_id) AS 'Total Number of payment', Min(amount) AS 'Lowest Payment', AVG(amount) AS 'Average Payment', 
	   MAX(amount) AS 'HIGHEST PAYMENT', SUM(amount) AS 'Total Of all Payments'
       from payment
       order by payment_id
*/

-- 5.	Display all film titles and descriptions only for descriptions that have both the words ‘dog’ and ‘squirrel’ in it. 
--      Sort alphabetically by title. 6 rows returned. (6)

/*
SELECT title, description
FROM film
WHERE description LIKE '%dog%' AND description LIKE '%squirrel%'
order by title ASC
*/
-- 6.	 a) display the average film length (2)
/* 
SELECT ROUND(AVG(Length),1) AS "Average Movie Time"
fROM Film
*/
        -- b)  Display films with a length longer than the average length. Sort by length, highest to lowest. (6)
/*
SELECT title,length
FROM film
WHERE length> (SELECT avg(length) FROM film)
ORDER BY length DESC; 
*/
-- 7.	Display the total rental amounts by customer for payment dates in July 2005 only. 
		-- Then display only results that total more than $50. Sort by customer ID. Use payment table - 179 rows returned (10)
/*
SELECT customer_Id, SUM(amount)  'Total Amount'
from payment
WHERE (Year(payment_date) =2005 AND MONTH(payment_date) = 07 )
Group by customer_id
HAVING SUM(amount)>=50   
order by customer_Id;
*/



-- 8.	Display rental ID, last name, first name for customers that are not active.  Use rental and customer tables -not all rows are showing here. (6)
/*
SELECT rental_Id, last_name,first_name
from rental
LEFT JOIN customer 
ON rental.customer_id = customer.customer_id
Where active IS FALSE
order by last_name
*/
-- 9.	Code an INSERT statement to add a category of ‘Zombie Programmers’ to category table. Use a column list using the name column only. (4)

/*
INSERT INTO category(category_id,name,last_update)
values (17,'Zombie Programmers','2002-06-12 07:32:12');
SELECT name
from category
ORDER BY name Asc;
*/

-- 10.	Code a DELETE statement to delete the row you added in question 10. (3)
/*
DELETE FROM category
WHERE name = 'Zombie Programmers';
*/


-- 11.	Code an UPDATE statement to modify the customers table.  Change email address to the word ‘reset’ for non-active customers only. (4)
/*
UPDATE customer
SET email ='reset'
WHERE active IS FALSE;
*/
-- 12.	Write the statement to create an index for the email column in the customers table using a standard index name. (4)
/*
CREATE INDEX email_index ON customer (email);
*/

-- 13.	Display the indexes for the customers table. (2)
/*
SELECT INDEX
from customer; 
*/