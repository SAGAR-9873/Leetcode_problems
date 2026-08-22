with cte as (SELECT t1.id as id1 ,
t1.p_id as  p_id1, t2.id as id2,t2.p_id  as p_id2
FROM Tree t1 left join Tree t2 
on t1.id = t2.p_id)
SELECT distinct id1 as id ,
CASE 
     when p_id1 is null then "Root" 
     when id2 and p_id2 is not NULL then "Inner" 
     when id2 is null and p_id2 is null then "Leaf"
     else " "
     end as type
from cte ;     

