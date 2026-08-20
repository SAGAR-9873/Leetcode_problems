SELECT e1.name as Employee
FROM Employee e1 inner join Employee e2 
ON e1.managerId = e2.id 
where e1.salary > e2.salary