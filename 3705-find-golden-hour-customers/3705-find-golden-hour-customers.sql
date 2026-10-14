SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN TIME(order_timestamp) BETWEEN '11:00:00' AND '14:00:00'
                  OR TIME(order_timestamp) BETWEEN '18:00:00' AND '21:00:00'
                THEN 1 ELSE 0
            END
        ) / COUNT(order_id),
        0
    ) AS peak_hour_percentage,
    ROUND(AVG(order_rating), 2) AS average_rating
FROM restaurant_orders
GROUP BY customer_id
HAVING COUNT(order_id) >= 3
   AND 100.0 * SUM(
        CASE
            WHEN TIME(order_timestamp) BETWEEN '11:00:00' AND '14:00:00'
              OR TIME(order_timestamp) BETWEEN '18:00:00' AND '21:00:00'
            THEN 1 ELSE 0
        END
   ) / COUNT(order_id) >= 60
   AND 100.0 * COUNT(order_rating) / COUNT(order_id) >= 50
   AND AVG(order_rating) >= 4
ORDER BY average_rating DESC, customer_id DESC;

-- WITH cte as (
--     select  customer_id , total_orders , average_rating ,
-- ROUND(
--     (SUM(CASE WHEN TIME(order_timestamp) BETWEEN '11:00' AND '14:00' 
--                 OR TIME(order_timestamp) BETWEEN '18:00' AND '21:00' 
--          THEN 1.0 ELSE 0.0 END) / total_orders) * 100, 0
-- ) AS peak_hour_percentage,
-- SUM(CASE WHEN order_rating IS NOT NULL THEN 1 ELSE 0 END )/total_orders * 100 AS average_rating_PER
-- from
-- (select customer_id ,
--         order_timestamp , 
--         order_rating ,
--         count(order_id) over (partition by customer_id ) as total_orders ,
--         round(avg(order_rating) over (partition by customer_id),2) as average_rating 
-- from restaurant_orders ) as t 
-- where total_orders >= 3
-- group by customer_id 
-- )

-- select customer_id , total_orders , peak_hour_percentage , average_rating
-- from cte 
-- where  peak_hour_percentage >= 60 and average_rating_PER >= 50 and average_rating >= 4
-- order by average_rating desc , customer_id desc 

