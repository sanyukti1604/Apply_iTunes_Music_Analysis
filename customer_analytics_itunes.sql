CREATE DATABASE Apple_itunes_music;
use Apple_itunes_music;
-----------------------
select * from album;
select * from artist;
select * from artist;
select * from customer;
select * from employee;
select * from genre;
select * from invoice;
select * from invoice_line;
select * from media_type;
select * from playlist;
select * from playlist_track;

---- customer_analytics------
---- 1 Which customers have spent the most money on music?
select c. customer_id, c.first_name, c.last_name, c.country, sum(i.total) as total_spent from customer c
join invoice i on c.customer_id = i.customer_id 
group by c.customer_id, c.first_name, c.last_name, c.country 
order by total_spent desc;
#limit 10; 

---- 2 What is the average customer lifetime value?
select round(sum(invoice.total) / count(DISTINCT c.customer_id), 2) as AverageCLV
from customer c 
join invoice on invoice.customer_id = c.customer_id;

---- 3 How many customers have made repeat purchases versus one-time purchases?
select purchaseType,
count(*) as customercount
from(select 
customer_id,
case
when count(invoice_id) = 1 then 'one time buyer'
else 'Repeat buyer'
End as purchaseType 
from invoice
group by Customer_id
) as customer_groups
group by purchaseType;

SELECT COUNT(*) 
FROM (
    SELECT customer_id
    FROM invoice
    GROUP BY customer_id
    HAVING COUNT(invoice_id) = 1
) AS one_time_customers;

---- 4 Which country generates the most revenue per customer?

SELECT
c.country,
round(sum(i.total) / count(DISTINCT c.customer_id), 2) as RevenueperCustomer
from customer c
join invoice i on i.customer_id = c.customer_id
group by c.country
order by  RevenuePerCustomer desc;

# 5 Which customers haven't made a purchase in the last 6 months?

SELECT max(invoice_date) from invoice;

SELECT c.customer_id, c.first_name, c.last_name, c.email
FROM customer c
LEFT JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
HAVING MAX(i.invoice_date) < DATE_SUB((SELECT MAX(invoice_date) FROM invoice), INTERVAL 6 MONTH)
   OR MAX(i.invoice_date) IS NULL;































