-- WITH cte1 AS (
--     SELECT store_id,
--            most_exp_product,
--            cheapest_product,
--            imbalance_ratio
--     FROM (
--         SELECT
--             i1.store_id,
--             i1.product_name AS most_exp_product,
--             i2.product_name AS cheapest_product,
--             ROUND((i2.quantity / i1.quantity), 2) AS imbalance_ratio,
--             MAX(i1.price) OVER (PARTITION BY i1.store_id) AS exp,
--             MIN(i1.price) OVER (PARTITION BY i1.store_id) AS low,
--             i1.quantity AS q1,
--             i2.quantity AS q2,
--             i1.price AS p1,
--             i2.price AS p2
--         FROM inventory i1
--         JOIN inventory i2
--             ON i1.store_id = i2.store_id
--     ) AS q
--     WHERE exp = p1
--       AND low = p2
--       AND q1 < q2
-- ),

-- cte2 AS (
--     SELECT store_id
--     FROM (
--         SELECT store_id,
--                COUNT(product_name) AS idk
--         FROM inventory
--         GROUP BY store_id
--     ) AS f5
--     WHERE idk >= 3
-- )

-- SELECT cte2.store_id , s.store_name ,s.location,  cte1.most_exp_product,  cte1.cheapest_product, cte1.imbalance_ratio
-- FROM cte1
-- JOIN cte2
--     ON cte1.store_id = cte2.store_id join stores as s on s.store_id = cte1.store_id 

-- order by cte1.imbalance_ratio desc    

-- with cte as (
--     SELECT   s.store_id ,
--          s.store_name ,
--          s.location , 
--          i.product_name ,
--          rank() over (partition by s.store_id order by i.price desc) as most_exp_product,
--          rank() over (partition by s.store_id order by i.price ) as cheapest_product,
--          i.quantity
-- FROM inventory i left join stores s 
-- on i.store_id = s.store_id )
-- select c1.store_id ,
--          c1.store_name ,
--          c1.location , 
--          c1.product_name
-- from cte c1 join cte c2 
-- on  c1.most_exp_product = 1 or c1.cheapest_product = 1 


-- select store_id ,
--        (select case when price = max(price) then product_name else "no_product" end as most_exp_product from inventory  group by store_id ) ,
--        (select case when price = min(price) then product_name else "no_product" end as cheapest_product from inventory group by store_id )
-- from inventory 

-- select case when price = max(price) then product_name else "no_product" end as most_exp_product from inventory  group by store_id 
-- union all

-- select case when price = min(price) then product_name else "no_product" end as most_exp_product from inventory  group by store_id 



-- select store_id ,
--        count(product_name)
-- from inventory 
-- group by store_id

-- with cte as (
-- select store_id ,
--          count(product_name) over(partition by store_id) as c ,
--          rank() over (partition by store_id order by price desc)as r, product_name
-- from inventory)

-- select c1.store_id , c1.r ,c2.c, c1.product_name , c2.product_name
-- from cte c1 join cte c2 
-- on  c1.store_id = c2.store_id
-- where c1.c>=3 and c1.r=1 or c1.c 
-- order by c1.store_id

-- with cte as (
-- select i1.store_id , rank() over (partition by i1.store_id order by i1.price desc) as r ,
-- CASE 
--     WHEN MAX(i1.price) OVER (PARTITION BY i1.store_id) = i1.price 
--      AND MIN(i1.price) OVER (PARTITION BY i2.store_id) = i2.price 
--     THEN i1.product_name 
--     ELSE 'no' 
-- END AS highest_product,

-- CASE 
--     WHEN MAX(i1.price) OVER (PARTITION BY i1.store_id) = i1.price 
--      AND MIN(i1.price) OVER (PARTITION BY i2.store_id) = i2.price 
--     THEN i2.product_name 
--     ELSE 'no' 
-- END AS lowest_product

-- from inventory i1 join inventory i2 
-- on i1.store_id = i2.store_id )
-- select store_id, h , l from cte 
-- where h!= "no" or l!= "no"\
with cte as (
select store_id , product_name , quantity , price ,cheapest_product , most_exp_product
from(select *,
    count(product_name) over(partition by store_id) as c,
    case when min(price) over(partition by store_id) = price then product_name else "no product" end as cheapest_product ,
    case when max(price) over(partition by store_id) = price then product_name else "no product" end as most_exp_product
    from inventory) as inv 
where c >= 3 and (cheapest_product != "no product" or most_exp_product !="no product")
)
select c1.store_id, s.store_name , s.location ,c2.most_exp_product,c1.cheapest_product,round((c1.quantity / c2.quantity),2) as imbalance_ratio
from cte c1 join cte c2
on c1.store_id=c2.store_id and (c1.cheapest_product != "no product" and c2.most_exp_product !="no product") and (c2.quantity < c1.quantity)
join stores s on c1.store_id = s.store_id
order by imbalance_ratio desc










