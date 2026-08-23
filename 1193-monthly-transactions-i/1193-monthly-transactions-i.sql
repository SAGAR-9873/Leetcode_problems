SELECT 
        DATE_FORMAT(trans_date, '%Y-%m') as month,
        country,count(amount) as trans_count,
        SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
        sum(amount) as trans_total_amount,
        SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions 
group by country,month;
















