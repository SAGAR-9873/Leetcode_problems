with cte as 
    (SELECT e.name as Employee ,
            e.salary as Salary,
            d.name as  Department ,
            DENSE_RANK() OVER (PARTITION BY e.DepartmentId order by e.salary desc) as r 
      FROM Employee e join Department d on e.departmentId = d.id) 
SELECT Department,
       Employee,
       Salary  
 FROM  cte 
where r <= 3