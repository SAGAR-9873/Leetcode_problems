-- with cte as (SELECT  
--     row_number()over (partition by employee_id order by review_date desc) as rnks,p.employee_id ,
--     count(p.employee_id) over (partition by p.employee_id)as cnt, 
--     lag(p.rating) over (partition by p.employee_id order by review_date ) as f,p.rating,
--     lead(p.rating) over (partition by p.employee_id order by review_date ) as n,
--     p.review_date
-- FROM performance_reviews p 
-- order by  employee_id, rnks )

-- select c.employee_id, e.name ,(c.n-c.f) as improvement_score  
-- from cte c  join employees e
-- on c.employee_id = e.employee_id
-- where rnks <= 3 and cnt >= 3
-- and f < rating and rating < n
-- group by c.employee_id
-- order by (c.n-c.f) desc








WITH ranked AS (
    SELECT
        p.*,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY review_date DESC
        ) AS rn
    FROM performance_reviews p
),

last3 AS (
    SELECT
        *,
        LAG(rating) OVER (
            PARTITION BY employee_id
            ORDER BY review_date
        ) AS previous_rating
    FROM ranked
    WHERE rn <= 3
)

SELECT
    l.employee_id,
    e.name,
    MAX(l.rating) - MIN(l.rating) AS improvement_score
FROM last3 l
JOIN employees e
    ON l.employee_id = e.employee_id
GROUP BY l.employee_id, e.name
HAVING COUNT(*) = 3
   AND MIN(CASE
       WHEN previous_rating IS NOT NULL
       THEN rating > previous_rating
       ELSE TRUE
   END) = 1
ORDER BY improvement_score DESC, e.name ASC;