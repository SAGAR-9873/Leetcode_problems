-- with cte as 
--     (SELECT e.name as Employee ,
--             e.salary as Salary,
--             d.name as  Department ,
--             DENSE_RANK() OVER (PARTITION BY e.DepartmentId order by e.salary desc) as r 
--       FROM Employee e join Department d on e.departmentId = d.id) 
-- SELECT Department,
--        Employee,
--        Salary  
--  FROM  cte 
-- where r <= 3

WITH ranked_salaries AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (
            PARTITION BY e.departmentId
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM Employee e
    JOIN Department d
        ON e.departmentId = d.id
)
SELECT
    Department,
    Employee,
    Salary
FROM ranked_salaries
WHERE salary_rank <= 3;