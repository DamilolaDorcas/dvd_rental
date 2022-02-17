--10 top cutomers, their emails,full names,address. 
--we use the payment and customer table

--{{ config(materialized = 'table') }}
with payment as(
select payment_id, customer_id, amount from payment),
customer as(
select first_name, last_name, email,  customer_id from customer),
payment_customer as(
select concat(first_name, ' ', last_name) as full_name, email, customer_id, payment_id, amount 
	from payment
	join customer
	using(customer_id)
),

final as(
select full_name, email,  sum(amount) as customer_payment 
from payment_customer
	group by 1, 2
order by customer_payment desc
)

select * from final
limit 10
