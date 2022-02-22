

with country as(
    select 
    country_id,
    country
    from {{ source('public', 'country') }}
),

city as(
    SELECT
    city_id,
    country_id,
    city
    from {{ source('public', 'city') }}
),

address as(
    SELECT
    address_id,
    city_id
    from {{ source('public', 'address') }}
),

customer as(
    SELECT
    customer_id,
    address_id
    from {{ source('public', 'customer') }}
),

payment as(
    SELECT
    payment_id,
    customer_id,
    amount
    from {{ source('public', 'payment') }}
),

highest_sales_vol as(
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
    from highest_sales_vol
    group by 1, 2,3
    order by 2, 3 desc
    
    )
select * from final
group by 1, 2,3