  with dept_pos as 
    (select 
    dense_rank() over(partition by d.name order by salary desc) as dept_rank,
    e.name as Employee ,
    d.name as Department,
    salary
    from Employee as e 
    left join department as d 
    on e.departmentID =d.id)
    select 
         Department,
        Employee,
        salary
    from dept_pos
    where dept_rank <= 3
    order by salary desc ;