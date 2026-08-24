with cte1 as (select  u.name ,count(*) as counts 
from MovieRating mr left join Users u 
on mr.user_id = u.user_id
group by u.user_id
order by counts desc ,u.name asc
limit 1 ),cte2 as 
(select m.title , avg(mr.rating) as avg_rating
from MovieRating mr left join Movies m
on mr.movie_id = m.movie_id
where created_at >= "2020-02-01" and created_at <= "2020-02-29"
group by m.movie_id
order by  avg_rating desc , m.title asc
limit 1)

SELECT name as results
FROM cte1

UNION ALL

SELECT title
FROM cte2
;


