----  7. Customer Retention & Purchase Patterns
use Apple_itunes_music;
---- 7.1 What is the distribution of purchase frequency per customer?

 #Step 1: Purchases per Customer
 
 select customer_id, count(*) as purchase_amount
 from invoice 
 group by customer_id
 order by purchase_amount DESC;
 
 # Step 2: Purchase Frequency Distribution
 
 select purchase_count, count(*) as number_of_customer
 from ( select customer_id, count(*) as purchase_count
 from invoice group by customer_id ) as customer_purchases
 group by purchase_count
 order by purchase_count;
 
 ---- 7.2 How long is the average time between customer purchases?
 
SELECT 
    ROUND(AVG(DATEDIFF(curr.invoice_date, prev.invoice_date)), 2) AS avg_days_between_purchases
FROM invoice AS curr
JOIN invoice AS prev 
    ON curr.customer_id = prev.customer_id
    AND curr.invoice_date > prev.invoice_date
WHERE NOT EXISTS (
    SELECT 1
    FROM invoice mid
    WHERE mid.customer_id = curr.customer_id
      AND mid.invoice_date > prev.invoice_date
      AND mid.invoice_date < curr.invoice_date
);

---- 7.3 What percentage of customers purchase tracks from more than one genre? 
SELECT 
    ROUND(100.0 * COUNT(DISTINCT multi_genre.customer_id) / COUNT(DISTINCT c.customer_id), 2) AS percentage_multi_genre_customers
FROM customer c
LEFT JOIN (
    SELECT 
        i.customer_id
    FROM invoice i
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN tracks t ON il.track_id = t.track_id
    GROUP BY i.customer_id
    HAVING COUNT(DISTINCT t.genre_id) > 1
) AS multi_genre
ON c.customer_id = multi_genre.customer_id;























