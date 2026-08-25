-- select max(e1.salary) as SecondHighestSalary
-- from Employee e1 inner join Employee e2 on
-- e1.salary < e2.salary

-- select max(salary) as SecondHighestSalary
-- from Employee
-- where salary
-- not in 
-- (select max(salary) from Employee);


SELECT (
    SELECT DISTINCT salary 
    FROM Employee 
    ORDER BY salary DESC 
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;

