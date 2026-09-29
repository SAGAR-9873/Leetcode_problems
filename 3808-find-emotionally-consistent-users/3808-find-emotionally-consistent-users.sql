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

-- mistakes 
-- select * from (with cte as (
-- SELECT  user_id,
--         count(reaction) as r,
--         count(distinct content_id) as c,
--         max(reaction) over(partition by user_id) as dominant_reaction 
-- FROM reactions 
-- GROUP BY user_id)

-- select r.user_id,c.dominant_reaction,
--        round((sum(case when r.reaction = c.dominant_reaction then 1 else 0 end) / c.r ),2) as reaction_ratio
-- from reactions r left join cte c
-- on r.user_id = c.user_id 
-- group by r.user_id ) as cte2 
-- where reaction_ratio >= 0.60
-- order by reaction_ratio desc


-- select user_id , dominant_reaction ,round((c/t),2) as  reaction_ratio 
-- from (
-- select * , row_number() over (partition by user_id order by c desc) as u  
-- from 
-- (select 
--        user_id ,reaction as dominant_reaction , 
--        count(content_id) over (partition by user_id) as t ,
--        count(user_id) over (partition by user_id , reaction) as c ,
          
-- from reactions 
--  )as cte1) as cte2 
--  where u = 1 and (c/t) > 0.60 and o >= 5 
--  order by (c/t) desc

-- select * , row_number() over (partition by user_id order by c desc) as u  
-- from 
-- (select 
--        user_id ,reaction as dominant_reaction , 
--        count(content_id) over (partition by user_id) as t ,
--        count(user_id) over (partition by user_id , reaction) as c          
-- from reactions 
--  )as cte1



-- with cte1 as (
-- select 
--          user_id ,
--         count(distinct content_id) as t 
-- from reactions 
-- group by user_id ) ,cte2 as (

-- select * , row_number() over (partition by user_id order by c desc)
-- from
-- (
-- select user_id , count(reaction) as c , reaction 
-- from reactions
-- group by reaction ,user_id 
-- order by  c desc , user_id desc) as q 
-- )
-- select * 
-- from cte2 as c2 left join cte1 as c1 
-- on c1.user_id = c2.user_id 
-- where t >= 5 and 


--  select user_id , count(reaction) as c,count(user_id) as a, reaction 
-- from reactions
-- group by reaction ,user_id 
-- order by  c desc , user_id desc


-- select user_id , count(user_id) as a 
-- from reactions
-- group by user_id