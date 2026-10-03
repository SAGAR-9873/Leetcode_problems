with cte as (
select h1.driver_id ,
 round(avg(h1.distance_km /h1.fuel_consumed) over(partition by h1.driver_id),2) as first_half_avg ,
 round(avg(h2.distance_km /h2.fuel_consumed) over(partition by h2.driver_id),2) as second_half_avg,
 round(avg(h2.distance_km /h2.fuel_consumed) over(partition by h2.driver_id) - avg(h1.distance_km /h1.fuel_consumed) over(partition by h1.driver_id),2) as efficiency_improvement
from 
(select * 
from trips 
where extract(month from trip_date)<7) as h1
join 
(select * 
from trips 
where extract(month from trip_date)>6) as h2
on h1.driver_id = h2.driver_id)
select distinct d.driver_id ,d.driver_name ,c.first_half_avg ,c.second_half_avg, c.efficiency_improvement 
from cte c join drivers d
on d.driver_id = c.driver_id
where c.efficiency_improvement > 0
order by c.efficiency_improvement desc , d.driver_name asc