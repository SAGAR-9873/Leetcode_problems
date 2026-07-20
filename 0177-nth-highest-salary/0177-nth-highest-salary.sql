CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    SELECT salary
    FROM 
    (SELECT 
      salary ,
      DENSE_RANK() OVER (ORDER BY salary DESC) AS SALARY_RANK
      FROM Employee
      order by salary  ) AS SALARY_ANALYSIS
      where SALARY_RANK = N 
      LIMIT 1
      
      );
END