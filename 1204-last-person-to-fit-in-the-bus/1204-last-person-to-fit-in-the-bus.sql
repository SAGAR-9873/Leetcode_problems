select person_name
from
(select person_name,
sum(weight) over(order by turn ) as l 
from Queue ) as t 
where l <= 1000
order by  l desc
limit 1 ;
