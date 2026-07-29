WITH cte AS (
    SELECT 
        e.id, 
        e.name,
        COUNT(m.id) AS no_of_emp
    FROM Employee AS e 
    JOIN Employee AS m ON m.managerId = e.id
    GROUP BY e.id, e.name
)
SELECT name 
FROM cte 
WHERE no_of_emp >= 5;