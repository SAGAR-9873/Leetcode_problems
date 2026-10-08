WITH cte AS (
    SELECT *,
           DATE_SUB(meeting_date, INTERVAL WEEKDAY(meeting_date) DAY) AS week_start,
           SUM(duration_hours) OVER (
               PARTITION BY employee_id,
                            DATE_SUB(meeting_date, INTERVAL WEEKDAY(meeting_date) DAY)
           ) AS time_taken
    FROM meetings
),
heavy AS (
    SELECT *
    FROM cte
    WHERE time_taken > 20
),
result AS (
    SELECT 
        c.employee_id,
        e.employee_name,
        e.department,
        COUNT(DISTINCT c.week_start) AS meeting_heavy_weeks
    FROM heavy c
    JOIN employees e 
        ON c.employee_id = e.employee_id
    GROUP BY 
        c.employee_id,
        e.employee_name,
        e.department
)
SELECT *
FROM result
WHERE meeting_heavy_weeks >= 2
order by meeting_heavy_weeks desc ,employee_name asc