

with country as(
    select 
    country_id,
    country
    from country
),

city as(
    SELECT
    city_id,
    country_id,
    city
    from city
),

address as(
    SELECT
    address_id,
    city_id
    from address
),

customer as(
    SELECT
    customer_id,
    address_id
    from customer
),

payment as(
    SELECT
    payment_id,
    customer_id,
    amount
    from payment
),

all_col as(
    SELECT
    country, 
    sum(amount) as vol_of_sales,
    count(customer_id) as customer_base
    from country
    join city using(country_id)
    join address using(city_id)
    join customer using(address_id)
    join payment using(customer_id)
    group by country
),   

final as( 
    SELECT
    country,
    vol_of_sales,
    customer_base
    from all_col
    group by 1, 2,3
    order by 3 desc
    
    )
select * from final
group by 1, 2,3