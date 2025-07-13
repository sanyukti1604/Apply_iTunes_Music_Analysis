----  5. Employee & Operational Efficiency
---- 5.1 Which employees (support representatives) are managing the highest-spending customers?
use Apple_itunes_music;
SELECT 
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    c.customer_id,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    ROUND(SUM(i.total), 2) AS total_spent
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY e.employee_id, c.customer_id
ORDER BY total_spent DESC;

---- 5.2 What is the average number of customers per employe?

SELECT 
    e.first_name,
    e.last_name,
    COUNT(c.customer_id) AS total_customers
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id
GROUP BY e.employee_id
ORDER BY total_customers DESC;


---- 5.3 Which employee regions bring in the most revenue?

SELECT 
    e.country AS region,
    ROUND(SUM(i.total), 2) AS total_revenue
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY e.country
ORDER BY total_revenue DESC;

# 6  Geographic Trends
# 6.1 Which countries or cities have the highest number of customers?
# By Countries
SELECT COUNTRY, COUNT(*) AS total_customer from customer 
group by country
order by total_customer DESC;

# By Cities 
select city, count(*) as total_customer from customer
group by city
order by total_customer DESC;

# 6.2 How does revenue vary by region?
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

# 6.3 Are there any underserved geographic regions (high users, low sales)?
SELECT 
    c.country,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(SUM(i.total), 2) AS total_revenue,
    ROUND(SUM(i.total) / COUNT(DISTINCT c.customer_id), 2) AS avg_revenue_per_customer
FROM customer c
LEFT JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.country
ORDER BY total_customers DESC;
























