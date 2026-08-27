with cte as (select stock_name ,
sum(case when operation="Sell" then price
else 0 end ) as S,
sum(case when operation="Buy" then price
else 0 end ) as B
from Stocks
group by stock_name )
select stock_name ,
S-B as capital_gain_loss
from cte ;