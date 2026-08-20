
SELECT max(num) as num
from (
SELECT num, count(num) as c 
FROM MyNumbers
group by num) as t 
where c = 1

