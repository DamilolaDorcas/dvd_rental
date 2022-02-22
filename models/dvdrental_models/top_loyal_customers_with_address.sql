--10 top cutomers, their emails,full names,address. 
--we used the payment,address and customer table

with payment as(
select 
	customer_id, 
	amount 
	from  {{ source('public', 'payment') }}
),

customer as(
select 
	first_name, 
	last_name, 
	address_id, 
	email,  
	customer_id 
	from  {{ source('public', 'customer') }}
),

address as(
	SELECT
	address_id, 
	address,
	district,
	city_id
	from  {{ source('public', 'address') }}
),

city as(
	select 
	city_id,
	city,
	country_id
	from  {{ source('public', 'city') }}
),

country as(
	select
	country_id,
	country
	from  {{ source('public', 'country') }}
),
loyal_customer as(
select 
	concat(first_name, ' ', last_name) as full_name,
	concat(address, ', ', city, ', ', country) as customer_address,
	customer_id, 
	amount,
	address,
	address_id
	from payment
	join customer
	using(customer_id)
	join address
	using(address_id)
	join city
	using (city_id)
	join country
	using(country_id)
),

final as(
select 
	full_name, 
	customer_address, 
	--address_id,
	sum(amount) as customer_payment 
	from loyal_customer
	group by 1, 2
	order by customer_payment desc
)

select * from final
limit 10
