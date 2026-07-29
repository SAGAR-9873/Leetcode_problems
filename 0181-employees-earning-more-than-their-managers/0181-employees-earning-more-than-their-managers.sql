# Write your MySQL query statement below
select m.name as Employee
from Employee as e join Employee as m on e.id=m.managerId
where m.salary > e.salary;