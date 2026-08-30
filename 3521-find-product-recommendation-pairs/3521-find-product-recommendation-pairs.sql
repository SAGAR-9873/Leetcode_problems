WITH cte AS (
    SELECT 
        t1.product_id AS product1_id, 
        t2.product_id AS product2_id, 
        COUNT(DISTINCT t1.user_id) AS customer_count
    FROM ProductPurchases t1 
    INNER JOIN ProductPurchases t2 
        ON t1.user_id = t2.user_id 
        AND t1.product_id < t2.product_id 
    GROUP BY t1.product_id, t2.product_id
    HAVING customer_count >= 3
)
SELECT 
    c.product1_id,
    c.product2_id,
    p1.category AS product1_category,
    p2.category AS product2_category,
    c.customer_count  
FROM cte c 
INNER JOIN ProductInfo p1 ON c.product1_id = p1.product_id 
INNER JOIN ProductInfo p2 ON c.product2_id = p2.product_id 
ORDER BY 
    c.customer_count DESC, 
    c.product1_id ASC, 
    c.product2_id ASC;
