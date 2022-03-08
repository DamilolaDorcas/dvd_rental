

with customer as (
 select
	customer_id,
	store_id,
	first_name,
	last_name,
	email,
	active
 from customer
),

payment as (
 	select 
	payment_id,
	customer_id,
	staff_id,
	rental_id,
	amount,
	payment_date
	from payment
),

 customer_payment as (
 	select 
	 concat(first_name, ' ', last_name)as customer_full_name,
	 amount,
	 payment_date
	 from customer
	 join payment
	 using(customer_id)
 ),
 final as(
 	select 
	customer_full_name,
 	sum(amount)
 	from customer_payment
 	group by 1
 	order by 2 desc
 )
 select * from final
 
 


