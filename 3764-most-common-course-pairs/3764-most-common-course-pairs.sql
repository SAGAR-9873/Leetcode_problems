with cte as 
(
    select c1.*
from course_completions c1 join 
(select user_id,avg(course_rating) as a , count(course_id)  as b 
from course_completions
group by user_id
having (a >=4) and ( b>=5)) as c2
on c1.user_id = c2.user_id )

select first_course , second_course , count( user_id) as transition_count from (
select user_id,course_name as first_course , 
lead(course_name ) over (partition by user_id order by completion_date) as second_course 
from cte ) as c
where  second_course  is not null
group by first_course , second_course   
order by transition_count desc , first_course , second_course  




