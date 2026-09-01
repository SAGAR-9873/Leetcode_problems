WITH cte AS (
    SELECT
        s.*,
        CASE
            WHEN MONTH(sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(sale_date) IN (6, 7, 8) THEN 'Summer'
            ELSE 'Fall'
        END AS season
    FROM Sales s
),

totals AS (
    SELECT
        c.season,
        p.category,
        SUM(c.quantity) AS total_quantity,
        SUM(c.quantity * c.price) AS total_revenue
    FROM cte c
    JOIN Products p
        ON c.product_id = p.product_id
    GROUP BY c.season, p.category
),

ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY season
            ORDER BY
                total_quantity DESC,
                total_revenue DESC,
                category ASC
        ) AS rn
    FROM totals
)

SELECT
    season,
    category,
    total_quantity,
    total_revenue
FROM ranked
WHERE rn = 1
ORDER BY season ASC;