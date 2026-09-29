with cte as (
select  customer_id ,
        sum(case when transaction_type = "purchase" then 1 else 0 end ) as s ,
        sum(case when transaction_type = "refund" then 1 else 0 end ) as u,
        datediff(max(transaction_date ),min(transaction_date)) as t
from customer_transactions c1 
group by customer_id)

select customer_id 
from cte
where  (u/(s+u))*100 < 20 and
        t >= 30 and    
        s >= 3 ;


