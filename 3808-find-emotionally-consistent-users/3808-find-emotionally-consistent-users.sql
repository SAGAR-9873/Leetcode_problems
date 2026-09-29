with cte1 as (
select user_id , count(distinct content_id) as t 
from reactions 
group by user_id ),cte2 as 
(
select * , row_number() over (partition by user_id order by c desc) as n
from
(
select user_id , count(reaction) as c , reaction 
from reactions
group by reaction ,user_id 
order by  c desc , user_id desc) as q )

select c2.user_id , c2.reaction as  dominant_reaction , round((c/t),2) as reaction_ratio from 
cte2 c2 left join cte1 c1
on c2.user_id = c1.user_id 
where n = 1 and  t>=5 and  (c/t) >=0.60
order by (c/t) desc