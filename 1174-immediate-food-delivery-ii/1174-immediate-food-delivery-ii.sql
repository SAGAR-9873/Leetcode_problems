with cte as (select customer_id,min(distinct order_date) as first_order
from Delivery 
group by customer_id)
select round((count(d.customer_id)/(select count(distinct customer_id) from Delivery))*100,2) as immediate_percentage
from Delivery d inner join cte c
on c.first_order = d.customer_pref_delivery_date  and c.customer_id = d.customer_id
