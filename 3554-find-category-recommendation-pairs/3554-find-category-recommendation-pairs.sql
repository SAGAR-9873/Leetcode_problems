with cte as (SELECT p1.* , p2.category
FROM ProductPurchases p1 join ProductInfo p2 
on p1.product_id  = p2.product_id )

select   c1.category as category1 , c2.category as category2 , count(distinct c1.user_id ) as customer_count 
from cte c1 left join cte c2 on c1.user_id = c2.user_id and c1.category < c2.category
where c2.category is not null
group by c1.category , c2.category
having count(distinct c1.user_id ) >= 3
order by customer_count desc , category1 , category2