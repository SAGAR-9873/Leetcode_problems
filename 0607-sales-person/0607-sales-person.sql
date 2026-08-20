select name
from SalesPerson 
where sales_id NOT IN 
(SELECT s.sales_id
FROM SalesPerson s inner join Orders o 
on s.sales_id = o.sales_id left join Company c on o.com_id= c.com_id
where c.name = "RED")



