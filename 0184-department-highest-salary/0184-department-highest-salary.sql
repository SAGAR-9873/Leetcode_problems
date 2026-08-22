select Department ,Employee , Salary 
from
(SELECT e.id as id ,
d.name as Department ,e.name as Employee,e.salary as Salary , 
max(e.salary)over(partition by d.name) as t 
FROM Employee as e left join Department d on 
e.departmentId =d.id)as c
where t =  Salary 
order by id