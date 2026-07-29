with cte as (
select *,
    lag(temperature) over( order by recordDate) as prev_temp,
    lag(recordDate) over( order by recordDate) as prev_date
from Weather )
select id 
from cte
where datediff(recordDate,prev_date)=1 and temperature > prev_temp 
 