WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY student_id, subject
               ORDER BY exam_date
           ) AS first_exam,
           ROW_NUMBER() OVER (
               PARTITION BY student_id, subject
               ORDER BY exam_date DESC
           ) AS latest_exam
    FROM Scores
)

SELECT
    student_id,
    subject,
    MAX(CASE WHEN first_exam = 1 THEN score END) AS first_score,
    MAX(CASE WHEN latest_exam = 1 THEN score END) AS latest_score
FROM ranked
GROUP BY student_id, subject
HAVING latest_score > first_score;