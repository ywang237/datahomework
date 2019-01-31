Use sakila;

#1a
select first_name, last_name
from actor;

#1b
select upper(concat(first_name, " ", last_name)) as "Actor Name"
from actor;

#2a
select actor_id, first_name, last_name
from actor
where first_name = "Joe";

#2b
select actor_id, first_name, last_name
from actor
where last_name like "%GEN%";

#2c

select first_name, last_name
from actor
where last_name like "%LI%"
order by last_name, first_name;

#2d
select country_id, country
from country
where country in ("Afghanistan", "Bangladesh", "China");

#3a
alter table actor 
add column description blob;

#3b
alter table actor
drop column description;

#4a
select last_name, count(last_name) 
from actor
group by last_name;

#4b
select last_name, count(last_name)
from actor
group by last_name
having count(last_name) > 1;

#4c
update actor
set first_name = "HARPO"
where first_name = "GROUCHO" and last_name = "WILLIAMS";

select * from actor
where last_name = "WILLIAMS";

#4d
update actor
set first_name = "GROUCHO"
where first_name = "HARPO" and last_name = "WILLIAMS";

select * from actor
where last_name = "WILLIAMS";

#5a
show create table address;

#6a
select staff.first_name, staff.last_name, address.address
from staff
left join address on staff.address_id = address.address_id;

#6b
select staff.staff_id, staff.first_name, staff.last_name, sum(payment.amount) as "total amount rung up"
from staff
left join payment on staff.staff_id = payment.staff_id
group by staff_id
having payment.payment_date = "2005-08-%% %%:%%:%%";

#I get an error that payment.payment_date is an unknown column

select payment_date from payment;

I get an error from filtering by date

#6c
select film.title, count(film_actor.actor_id) as "number of actors"
from film
inner join film_actor on film.film_id = film_actor.film_id
group by film.title;

#6d
select film.title, count(inventory.inventory_id) as "number of copies"
from film
left join inventory on film.film_id = inventory.film_id
group by film.title
having film.title = "Hunchback Impossible";

#6e
select customer.first_name, customer.last_name, sum(payment.amount) as "total amount paid"
from customer
left join payment on customer.customer_id = payment.customer_id
group by customer.customer_id
order by customer.last_name;

#7a
select name
from language;

select title, language_id
from film 
where language_id in
(
    select language_id
    from language
    where name = "English"
)
having title like 'K%' or title like 'Q%';

#7b
select first_name, last_name
from actor
where actor_id in
(
    select actor_id
    from film_actor
    where film_id in
    (
        select film_id 
        from film
        where title = "Alone Trip"
    )
);


#7c
select first_name, last_name, email
from customer where address_id in
(
    select address_id 
    from address where city_id in
    (
        select city_id
        from city
        where country_id in
		(
		    select country_id from
            country where country = "Canada"
		 )
     )    
);
        
    
#7d
select name 
from category;

select title 
from film
where film_id in
(
    select film_id
    from film_category
    where category_id in
    (
       select category_id
       from category
       where name = "Family"
	)
);

#7e 
select inventory.film_id, count(rental.rental_id) as "number of rents"
FROM rental
left join inventory on rental.inventory_id = inventory.inventory_id 
group by film_id
order by count(rental.rental_id) desc;

#7f
select staff.store_id, sum(payment.amount) as "total store amount"
FROM payment
left join staff on payment.staff_id = staff.staff_id
group by staff.store_id;

#7g
select store_id, city, country from (store inner join address
on store.address_id = address.address_id) 
inner join city on (address.city_id = city.city_id)
inner join country on (city.country_id = country.country_id);

#7h
select name, sum(amount) as "total revenue" from (payment inner join rental
on payment.rental_id = rental.rental_id)
inner join inventory on (rental.inventory_id = inventory.inventory_id)
inner join film_category on (inventory.film_id = film_category.film_id)
inner join category on (film_category.category_id = category.category_id)
group by name
order by sum(amount) desc limit 5;

#8a
create view top_genres as
select name, sum(amount) as "total revenue" from (payment inner join rental
on payment.rental_id = rental.rental_id)
inner join inventory on (rental.inventory_id = inventory.inventory_id)
inner join film_category on (inventory.film_id = film_category.film_id)
inner join category on (film_category.category_id = category.category_id)
group by name
order by sum(amount) desc limit 5;

#8b
select * from top_genres;

#8c
drop view top_genres;





















    
