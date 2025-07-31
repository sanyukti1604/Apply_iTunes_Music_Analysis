# apple_iTunes_Music_Analysis


This project is an in-depth SQL-based analysis of the iTunes Apple Music Store database. The objective is to extract actionable insights from multiple interrelated datasets to understand customer behavior, sales performance, content trends, and artist/genre success.

---

## Project Objectives

- Analyze customer purchasing behavior and identify high-value customers
- Explore monthly and yearly sales trends using invoices
- Evaluate product performance across genres, tracks, and artists
- Identify top-performing employees and countries based on revenue
- Discover patterns in repeat vs one-time customers

---

## Tools Used

- SQL (MySQL Workbench) – for querying, data cleaning, and transformation
- CSV files – exported query results for validation and reference

---

## Dataset Overview

The project uses multiple tables from the iTunes database:

- customer.csv
- invoice.csv
- invoice_line.csv
- track.csv
- genre.csv
- media_type.csv
- employee.csv
- artist.csv
- album.csv

These files represent a normalized relational database structure.

---

## Key Business Questions Answered

Customer Analytics:
- Who are the top-spending customers?
- What is the average lifetime value per customer?
- How many customers are repeat buyers vs one-time buyers?
- Which countries generate the most revenue per customer?
- Who hasn't purchased anything in the last 6 months?

Sales & Revenue Analysis:
- What are the monthly revenue trends over the last 2 years?
- What is the average value of each invoice?
- Which payment methods are most frequently used?
- How much revenue is contributed by each sales representative?
- Which months or quarters see peak sales?

Product & Content Analysis:
- Which tracks and albums generate the highest revenue?
- Are there any tracks or albums that have never been purchased?
- What is the average track price across different genres?
- How many tracks exist per genre and how does that relate to revenue?

Artist & Genre Performance:
- Who are the top 5 highest-grossing artists?
- Which genres are most popular by sales and revenue?
- Are some genres more popular in specific countries?

---

## Insights

- A small portion of customers drive a significant share of total revenue.
- Certain genres and artists are consistently top-performing across countries.
- Some albums and tracks are never purchased, suggesting catalog optimization opportunities.
- Repeat customers tend to spend more than one-time buyers.
- Revenue trends follow seasonal patterns that can inform marketing efforts.

---

## Conclusion

This project enhanced my practical skills in writing complex SQL queries, analyzing normalized relational databases, and extracting meaningful business insights from structured data. It demonstrates how data can be used to understand customers, improve sales strategies, and evaluate content performance — all of which are essential capabilities for a Data Analyst.

---
