-- PROBLEM 1: Duplicate Job Listings

/* Assume you are given the table below that shows job postings 
for all companies on the LinkedIn platform. Write a query to get the 
number of companies that have posted duplicate job listings */

-- LINK https://datalemur.com/questions/duplicate-job-listings

WITH job_listings_rank 
AS (
SELECT
    ROW_NUMBER() OVER (PARTITION BY company_id, title, description) AS ranking, 
    company_id, 
    title, 
    description 
  FROM job_listings
  )
SELECT COUNT(ranking) AS duplicate_job
FROM job_listings_rank
WHERE ranking = 2;

-- PROBLEM 2: Average Review Ratings

/* Given the reviews table, write a query to retrieve the average star 
rating for each product, grouped by month. The output should display the month 
as a numerical value, product ID, and average star rating rounded to two decimal places. 
Sort the output first by month and then by product ID. */

-- LINK: https://datalemur.com/questions/sql-avg-review-ratings

SELECT 
    EXTRACT(MONTH FROM submit_date) AS month,
    product_id,
    ROUND(AVG(stars), 2) AS avg_rating
FROM
    reviews
GROUP BY EXTRACT(MONTH FROM submit_date) , product_id
ORDER BY month , product_id;

-- PROBLEM 3: Card Issued Difference

/* Your team at JPMorgan Chase is soon launching a new credit card, and to gain some context,
you are analyzing how many credit cards were issued each month. Write a query that outputs the
name of each credit card and the difference in issued amount between the month with the most
cards issued, and the least cards issued. Order the results according to the biggest difference. */

-- LINK: https://datalemur.com/questions/cards-issued-difference

SELECT DISTINCT
    card_name,
    MAX(issued_amount) - MIN(issued_amount) AS difference
FROM
    monthly_cards_issued
GROUP BY 1;
