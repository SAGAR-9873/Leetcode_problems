-- with cte as (select c1.patient_id , datediff(c2.test_date, c1.test_date ) as recovery_time
-- from covid_tests c1 inner join covid_tests c2
-- on c1.patient_id = c2.patient_id and
--    c1.result = "Positive" and 
--    c2.result = "Negative"and 
--    c1.test_date < c2.test_date)
-- select c.patient_id ,p.patient_name ,p.age,MIN(c.recovery_time) AS recovery_time
-- from cte c join patients p
-- on c.patient_id = p.patient_id 
-- GROUP BY c.patient_id, p.patient_name, p.age
-- ORDER BY recovery_time ASC, p.age ASC;

WITH cte AS (
    SELECT
        c1.patient_id,
        DATEDIFF(c2.test_date, c1.test_date) AS recovery_time
    FROM covid_tests c1
    INNER JOIN covid_tests c2
        ON c1.patient_id = c2.patient_id
        AND c1.result = 'Positive'
        AND c2.result = 'Negative'
        AND c1.test_date < c2.test_date
        AND c1.test_date = (
            SELECT MIN(c3.test_date)
            FROM covid_tests c3
            WHERE c3.patient_id = c1.patient_id
              AND c3.result = 'Positive'
        )
)

SELECT
    c.patient_id,
    p.patient_name,
    p.age,
    MIN(c.recovery_time) AS recovery_time
FROM cte c
JOIN patients p
    ON c.patient_id = p.patient_id
GROUP BY c.patient_id, p.patient_name, p.age
ORDER BY recovery_time ASC, p.patient_name ASC;