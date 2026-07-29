# Write your MySQL query statement below
with cte as (
select 
count(email) over(partition by email) as ranks ,
email
from person)
select distinct email 
from cte
where ranks > 1  ;