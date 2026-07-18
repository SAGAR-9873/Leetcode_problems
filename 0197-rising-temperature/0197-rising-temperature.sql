# Write your MySQL query statement below
with temp_list as (
select *,
lag(temperature) over(order by recordDate) as previous_temperature,
lag(recordDate) over(order by recordDate) as previous_Date
from Weather 
)
select id as Id
from temp_list
where previous_temperature < temperature and 
DATEDIFF(recordDate, previous_Date) = 1 ;