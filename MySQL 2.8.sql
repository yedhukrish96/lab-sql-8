USE sakila;

#1-
#Write a query to display for each store its store ID, city, 
#and country.
SELECT  s.store_id, c.city, k.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country k ON c.country_id = k.country_id;

#2-
#Write a query to display how much business, in dollars, 
#each store brought in.
SELECT * FROM payment;
SELECT * FROM store;
SELECT * FROM staff;

SELECT s.store_id AS store, CONCAT('$', FORMAT(sum(p.amount),2)) AS amount 
FROM store s
JOIN customer c ON s.store_id = c.store_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY store;

#3-
#Which film categories are longest?
SELECT * FROM category;
SELECT * FROM film_category;

SELECT c.name AS cat_name, SEC_TO_TIME(avg(f.length*60)) AS avg_time
FROM category c
JOIN film_category m ON c.category_id = m.category_id
JOIN film f ON m.film_id = f.film_id
GROUP BY cat_name
ORDER BY avg_time desc;









#4-
#Display the most frequently rented movies in descending order.

SELECT f.title, COUNT(r.rental_date) AS times_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY times_rented DESC;






#5-
#List the top five genres in gross revenue in descending order.

SELECT c.name AS cat_name, CONCAT('$', FORMAT(sum(p.amount),2)) AS gross_revenue
FROM category c
JOIN film_category f USING (category_id) 
JOIN inventory i USING (film_id)
JOIN rental r USING (inventory_id)
JOIN payment p USING (rental_id)
GROUP BY cat_name
ORDER BY gross_revenue desc
LIMIT 5;






#6-
#is "Academy Dinosaur" available for rent from Store 1?
SELECT * FROM store;  -- to check for the store_id
SELECT * FROM film;   -- has the tile' Academy Dinosuar' in it
SELECT * FROM inventory; -- to check for the film_id in the inventory
SELECT * FROM rental;

SELECT * FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN store ON inventory.store_id = store.store_id
WHERE film.title = 'Academy Dinosaur' AND store.store_id = 1;


SELECT 
  CASE WHEN COUNT(*) > 0 THEN 'Yes' ELSE 'No' END AS available_for_rent
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN store ON inventory.store_id = store.store_id
WHERE film.title = 'Academy Dinosaur' AND store.store_id = 1;










#7-
#Get all pairs of actors that worked together.
SELECT * FROM actor;


SELECT DISTINCT
  CONCAT(a1.first_name, ' ', a1.last_name) AS actor1,
  CONCAT(a2.first_name, ' ', a2.last_name) AS actor2
FROM
  film_actor fa1
  JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id <>fa2.actor_id
  JOIN actor a1 ON fa1.actor_id = a1.actor_id
  JOIN actor a2 ON fa2.actor_id = a2.actor_id
ORDER BY actor1, actor2;








#8-
#Get all pairs of customers that have rented the same film 
#more than 3 times.








#9-
#For each film, list actor that has acted in more films.