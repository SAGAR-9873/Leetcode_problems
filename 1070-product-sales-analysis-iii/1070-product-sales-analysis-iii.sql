with cte as (
select product_id,min(year) as first_year
from sales
group by product_id)
select s.product_id ,c.first_year,s.quantity ,s.price
FROM Sales s
JOIN cte c
  ON s.product_id = c.product_id
 AND s.year = c.first_year