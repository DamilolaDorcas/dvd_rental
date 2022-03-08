--find the genre and their total sales
--we will be using category(to get the name/genre), count of category, 
--and payment(to get the total sales)
--Category >film_Category >film>inventory>rental >customer >payment

with category as(
    select 
    name as genre, 
    category_id 
    from {{ source('public', 'category') }}
),

film_category as(
    select 
    film_id, 
    category_id 
    from {{ source('public', 'film_category') }}
),

film as(
    select 
    film_id 
    from {{ source('public', 'film') }}
),

inventory as(
    select 
    inventory_id, 
    film_id 
    from {{ source('public', 'inventory') }}
),

rental as(
    select 
    rental_id, 
    inventory_id 
    from {{ source('public', 'rental') }}
),

payment as(
    select 
    amount,
    payment_id,
    rental_id,
    customer_id 
    from {{ source('public', 'payment') }}
),

customer as(
    select 
    customer_id 
    from {{ source('public', 'customer') }} 
),

top_rented as(
    select 
    genre,
    count(genre) as times_rented,
    sum(amount) as total_sales 
    from category 
    join film_category using(category_id)
    join film using(film_id)
    join inventory using(film_id)
    join rental using(inventory_id)
    join payment using(rental_id)
    join customer using(customer_id)
    group by 1),

final as( 
select genre, total_sales from top_rented
order by 2 desc
)

select * from final




