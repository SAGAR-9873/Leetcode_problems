with cte1 as (SELECT DISTINCT book_id ,(h-l) as rating_spread
FROM 
(SELECT 
rank() over(partition by r1.book_id ORDER BY r1.session_rating DESC , r2.session_rating ASC ) AS RANKS
,r1.book_id , r1.session_rating AS h ,r2.session_rating as l 
FROM reading_sessions r1 JOIN reading_sessions r2
ON r1.book_id=r2.book_id 
AND r1.session_rating >= 4 
AND r2.session_rating <=2) AS C 
WHERE RANKS = 1 
),
cte2 as (
select * from (
select book_id,count(book_id) as cn,
round(sum(case when session_rating >=4 or session_rating <=2 then 1 else 0 end )/count(book_id) ,2)as polarization_score
from reading_sessions 
group by book_id) as c2 
where cn >= 5 and polarization_score >= 0.60)
select 
cte1.book_id  , b.title,b. author, b.genre,b.pages ,cte1.rating_spread ,cte2.polarization_score
from cte1 join cte2
on cte1.book_id = cte2.book_id
join books b on b.book_id = cte1.book_id 
order by cte2.polarization_score desc , b.title desc  