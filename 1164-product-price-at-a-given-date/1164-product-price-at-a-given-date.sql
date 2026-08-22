-- select product_id , 
-- case 
-- when new_price is null then 10 
-- else new_price end as price
-- from
-- (with cte as (select p1.product_id,p1.new_price
-- from Products p1 inner join Products p2
-- on  p1.product_id =p2.product_id 
-- where p1.change_date <="2019-08-16"
-- group by p1.product_id)
-- select p.product_id , c.new_price
-- from Products p left join cte c 
-- on p.product_id = c.product_id
-- group by p.product_id) as w
WITH latest AS (
    SELECT
        product_id,
        MAX(change_date) AS latest_date
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
)

SELECT
    p.product_id,
    COALESCE(l.new_price, 10) AS price
FROM (
    SELECT DISTINCT product_id
    FROM Products
) p
LEFT JOIN (
    SELECT product_id, new_price
    FROM Products
    WHERE (product_id, change_date) IN (
        SELECT product_id, MAX(change_date)
        FROM Products
        WHERE change_date <= '2019-08-16'
        GROUP BY product_id
    )
) l
ON p.product_id = l.product_id;