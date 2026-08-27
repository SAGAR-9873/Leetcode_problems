with cte as (select s.user_id ,  sum(case when c.action = "confirmed" then 1
when c.action is null then 0 else 0 end) as r,count(c.user_id) as t
from Signups s left join Confirmations c 
on s.user_id = c.user_id
group by s.user_id)
select user_id , case when t > 0 then round(r/t,2) else 0 end as confirmation_rate
from cte 

