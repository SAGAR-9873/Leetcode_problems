with cte as (select * , 
max(monthly_amount) over(partition by user_id) as max_historical_amount,
case when event_date = max(event_date) over (partition by user_id) then monthly_amount else "NO" end as current_monthly_amount,
DATEDIFF(max(event_date) over (partition by user_id), min(event_date) over (partition by user_id)) AS DaysDifference
from subscription_events 
where user_id in 
(select user_id from subscription_events
where user_id not in (
select user_id from subscription_events 
where event_type = "cancel") 
and event_type = "downgrade"
group by user_id) )

select  user_id ,plan_name as current_plan , monthly_amount as current_monthly_amount ,max_historical_amount ,DaysDifference as days_as_subscriber 
from cte
where  current_monthly_amount < (0.50 * max_historical_amount ) and DaysDifference >= 60
and current_monthly_amount != "NO"
order by days_as_subscriber desc