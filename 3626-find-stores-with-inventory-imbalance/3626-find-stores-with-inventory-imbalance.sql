WITH cte1 AS (
    SELECT store_id,
           most_exp_product,
           cheapest_product,
           imbalance_ratio
    FROM (
        SELECT
            i1.store_id,
            i1.product_name AS most_exp_product,
            i2.product_name AS cheapest_product,
            ROUND((i2.quantity / i1.quantity), 2) AS imbalance_ratio,
            MAX(i1.price) OVER (PARTITION BY i1.store_id) AS exp,
            MIN(i1.price) OVER (PARTITION BY i1.store_id) AS low,
            i1.quantity AS q1,
            i2.quantity AS q2,
            i1.price AS p1,
            i2.price AS p2
        FROM inventory i1
        JOIN inventory i2
            ON i1.store_id = i2.store_id
    ) AS q
    WHERE exp = p1
      AND low = p2
      AND q1 < q2
),

cte2 AS (
    SELECT store_id
    FROM (
        SELECT store_id,
               COUNT(product_name) AS idk
        FROM inventory
        GROUP BY store_id
    ) AS f5
    WHERE idk >= 3
)

SELECT cte2.store_id , s.store_name ,s.location,  cte1.most_exp_product,  cte1.cheapest_product, cte1.imbalance_ratio
FROM cte1
JOIN cte2
    ON cte1.store_id = cte2.store_id join stores as s on s.store_id = cte1.store_id 

order by cte1.imbalance_ratio desc    