---- 6  Geographic Trends
use Apple_itunes_music; 

----  6.1 Which countries or cities have the highest number of customers?
# By Countries
SELECT COUNTRY, COUNT(*) AS total_customer from customer 
group by country
order by total_customer DESC;

# By Cities 
select city, count(*) as total_customer from customer
group by city
order by total_customer DESC;

----  6.2 How does revenue vary by region?
# by Country 
select billing_country,
ROUND(sum(total), 2) as total_revenue
from invoice 
group by billing_country
order by total_revenue DESC;

# by City 
select billing_city,
ROUND(sum(total), 2) as total_Revenue
from invoice
group by billing_city
order by total_revenue DESC;

----  6.3 Are there any underserved geographic regions (high users, low sales)?
SELECT 
    c.country,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(SUM(i.total), 2) AS total_revenue,
    ROUND(SUM(i.total) / COUNT(DISTINCT c.customer_id), 2) AS avg_revenue_per_customer
FROM customer c
LEFT JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.country
ORDER BY total_customers DESC;