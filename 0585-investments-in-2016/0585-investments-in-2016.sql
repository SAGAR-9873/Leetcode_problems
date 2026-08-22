with cte as (
SELECT pid,tiv_2015,tiv_2016,
COUNT(Pid) over(partition by tiv_2015) as v,
COUNT(Pid) over(partition by lat,lon ) as loc
from Insurance )
select round(sum(tiv_2016),2) as tiv_2016
from cte 
where v >= 2 and loc = 1

