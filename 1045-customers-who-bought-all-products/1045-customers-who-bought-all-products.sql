WITH cte AS (
    SELECT
        customer_id,
        COUNT(DISTINCT product_key) AS purchased
    FROM Customer
    GROUP BY customer_id
)

SELECT customer_id
FROM cte
WHERE purchased = (
    SELECT COUNT(*)
    FROM Product
);