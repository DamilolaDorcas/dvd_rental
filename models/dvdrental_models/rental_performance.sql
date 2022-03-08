with film as(
	select 
	title, 
	film_id, 
	rental_duration from film
),

inventory as(
	select 
	film_id, 
	inventory_id from inventory 
),

rental as(
	select 
	rental_date, 
	return_date, 
	inventory_id from rental
),
rental_performance as(
select title, 
	rental_duration, 
	extract('day' from return_date-rental_date) as rent_diff
	--extract('day' from rental_date) as rental_day
	from film
	join inventory using (film_id)
	join rental using(inventory_id)
	),

return as(
	select 
	--title, 
	--rental_duration, 
	---(return_day - rental_day) as rent_diff ,
	case when rent_diff < rental_duration then 'film returned early'
	when rent_diff = rental_duration then 'film returned on time'
	else 'film returned late'
	end as return
	from rental_performance
),

return_time as(
	select
	return, 
	count(return) as number from return
	group by 1
order by 2 desc
	)
	
select * from return_time