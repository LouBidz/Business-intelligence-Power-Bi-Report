SELECT month_name, 
       SUM(sale_price - cost_price) AS revenue
FROM forview
WHERE DATE_PART('year', TO_TIMESTAMP(dates, 'YYYY-MM-DD HH24:MI:SS.MS')) = 2022
GROUP BY month_name
ORDER BY revenue DESC
LIMIT 1;
