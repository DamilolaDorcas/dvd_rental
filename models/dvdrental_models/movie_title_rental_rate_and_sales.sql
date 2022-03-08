with film as(
	select 
	film_id, 
	title,
	rental_rate from film
),
inventory as(
	select
	inventory_id, 
	film_id from inventory
),
rental as(
	select 
	rental_id, 
	inventory_id, 
	customer_id 
	from rental
),
payment as(
	select 
	payment_id, 
	customer_id, 
	rental_id, 
	amount 
	from payment
),

all_col as(
	select 
	title, 
	rental_rate, 
	sum(amount) as total_Sales 
	from film
	join inventory using(film_id)
	join rental using(inventory_id)
	join payment using(customer_id)
	group by 1,2
	),
final as(
	select title, rental_rate, total_sales from all_col
	--group by 1,2
	order by 3 desc
)
select * from final

	