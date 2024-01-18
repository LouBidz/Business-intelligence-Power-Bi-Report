SELECT category
FROM forview
WHERE DATE_PART('year', TO_TIMESTAMP(dates, 'YYYY-MM-DD HH24:MI:SS.MS')) = 2021 AND full_region = 'Wiltshire, UK'
GROUP BY category
ORDER BY SUM(sale_price - cost_price) DESC
LIMIT 1 ;






