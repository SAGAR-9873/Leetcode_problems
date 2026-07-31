# Write your MySQL query statement below
select distinct class
from 
(
select class,
count(student) over(partition by class) as no_of_students 
from Courses ) as cte 
where no_of_students >= 5


