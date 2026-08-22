with cte as 
(SELECT requester_id  id from RequestAccepted 
UNION all 
SELECT accepter_id from RequestAccepted )
select id,count(id) over (partition by id) as num
from cte 
order by num desc
limit 1 ;
