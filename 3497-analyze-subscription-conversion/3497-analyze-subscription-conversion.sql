WITH user_summary AS (
    SELECT 
        user_id,
        -- Count how many paid activities they have
        SUM(CASE WHEN activity_type = 'free_trial' THEN 1 ELSE 0 END) AS f,
        SUM(CASE WHEN activity_type = 'paid' THEN 1 ELSE 0 END) AS p,
        -- Calculate the average duration of ONLY their free trials
        round(AVG(CASE WHEN activity_type = 'free_trial' THEN activity_duration END),2) AS trial_avg_duration,
         round(AVG(CASE WHEN activity_type = 'paid' THEN activity_duration END),2) AS paid_avg_duration
    FROM UserActivity 
    GROUP BY user_id
)
SELECT 
    user_id,
    trial_avg_duration,
    paid_avg_duration
FROM user_summary
WHERE p and f > 0; -- Only keep users who have at least one paid activity

