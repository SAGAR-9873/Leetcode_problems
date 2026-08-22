SELECT distinct num as ConsecutiveNums
from (
    SELECT id,num,
lag(num)over() as prev,
lead(num) over() as next
FROM Logs
) as t 
where num = prev and num = next ;

