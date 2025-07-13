#2. Sales & Revenue Analysis
# 1. What are the monthly revenue trends for the last two years
use Apple_itunes_music; 

SELECT 
  DATE_FORMAT(invoice_date, '%Y-%m') AS Month,
  ROUND(SUM(total), 2) AS MonthlyRevenue
FROM invoice
WHERE invoice_date >= DATE_SUB((SELECT MAX(invoice_date) FROM invoice), INTERVAL 2 YEAR)
GROUP BY Month
ORDER BY Month;

# 2. What is the average value of an invoice (purchase)?
select Round(avg(total),2) as total_puchase from invoice;

# 3. How much revenue does each sales representative contribute?
select e.employee_id , CONCAT (e.first_name, ' ' , e.last_name) as SalesRep,
ROUND(sum(i.total),2) as totalrevenue
from employee e
join customer c on e.employee_id = c.support_rep_id
join invoice i on c.customer_id = i.customer_id
group by e.employee_id, SalesRep
order by totalrevenue DESC;

# 4. Which months or quarters have peak music sales?
select DATE_FORMAT(invoice_date ,'%y -%M') as Month,
ROUND(SUM(total), 2 ) as MonthlyRevenue
from invoice
group by month
order by MonthlyRevenue DESC;

# 3 Product & Content Analysis
# 3.1 Which tracks generated the most revenue?
select invoice_line.track_id , ROUND(sum(invoice_line.unit_price * invoice_line.quantity), 2) as TotalRevenue
from invoice_line
join playlist_track on invoice_line.track_id = playlist_track.track_id
group by invoice_line.track_id, playlist_track.track_id
order by TotalRevenue DESC
limit 10;

# 3.2 Which albums or playlists are most frequently included in purchases?

SELECT 
    pt.playlist_id,
    COUNT(*) AS TimesPurchased
FROM invoice_line il
JOIN playlist_track pt ON il.track_id = pt.track_id
GROUP BY pt.playlist_id
ORDER BY TimesPurchased DESC
LIMIT 10;

# 3.3 Are there any tracks or albums that have never been purchased?
SELECT pt.track_id
FROM playlist_track pt
LEFT JOIN invoice_line il ON pt.track_id = il.track_id
WHERE il.track_id IS NULL;

# 3.4 What is the average price per track across different genres?
CREATE TABLE tracks (
    track_id INT PRIMARY KEY,
    genre_id INT,
    album_id INT
);
INSERT INTO tracks (track_id, genre_id, album_id) VALUES
(1, 1, 101),
(2, 1, 101),
(3, 2, 102),
(4, 2, 102),
(5, 3, 103),
(6, 3, 104),
(7, 4, 104),
(8, 4, 105),
(9, 1, 106),
(10, 2, 106);

SELECT 
    g.name AS Genre,
    ROUND(AVG(il.unit_price), 2) AS AvgTrackPrice
FROM invoice_line il
JOIN tracks t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.genre_id, g.name
ORDER BY AvgTrackPrice DESC;

# 3.5 How many tracks does the store have per genre and how does it correlate with sales?
# We'll break this into two clear parts using your tracks, genres, and invoice_line tables.
#Part 1: Total Number of Tracks per Genre
SELECT 
    g.name AS genre,
    COUNT(t.track_id) AS TotalTracks
FROM tracks t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.genre_id, g.name
ORDER BY TotalTracks DESC;

# Part 2: Total Tracks Sold per Genre (Sales Count)
SELECT 
    g.name AS genre,
    COUNT(il.track_id) AS TracksSold
FROM invoice_line il
JOIN tracks t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.genre_id, g.name
ORDER BY TracksSold DESC;

# Combined Result — Catalog vs. Sales
SELECT 
    g.name AS genre,
    COUNT(DISTINCT t.track_id) AS TotalTracks,
    COUNT(il.track_id) AS TracksSold
FROM tracks t
JOIN genre g ON t.genre_id = g.genre_id
LEFT JOIN invoice_line il ON t.track_id = il.track_id
GROUP BY g.genre_id, g.name
ORDER BY TracksSold DESC;

