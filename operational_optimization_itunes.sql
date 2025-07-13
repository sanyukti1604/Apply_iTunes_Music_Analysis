---- 7. Operational Optimization
use Apple_itunes_music;

---- 7.1 What are the most common combinations of tracks purchased together?
SELECT 
    t1.track_id AS track_1,
    t2.track_id AS track_2,
    COUNT(*) AS times_bought_together
FROM invoice_line t1
JOIN invoice_line t2 
  ON t1.invoice_id = t2.invoice_id 
  AND t1.track_id < t2.track_id
GROUP BY t1.track_id, t2.track_id
ORDER BY times_bought_together DESC
LIMIT 10;

---- 7.2 Are there pricing patterns that lead to higher or lower sales?
SELECT 
    unit_price,
    COUNT(*) AS times_sold,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(unit_price * quantity), 2) AS total_revenue
FROM invoice_line
GROUP BY unit_price
ORDER BY total_units_sold DESC;

---- 7.3 Which media types (e.g., MPEG, AAC) are declining or increasing in usage?

SELECT 
    DATE_FORMAT(i.invoice_date, '%Y-%m') AS month,
    mt.name AS media_type,
    COUNT(*) AS total_sales
FROM invoice i
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN tracks t ON il.track_id = t.track_id
JOIN media_type mt ON mt.media_type_id = mt.media_type_id
GROUP BY month, media_type
ORDER BY month ASC, total_sales DESC;


