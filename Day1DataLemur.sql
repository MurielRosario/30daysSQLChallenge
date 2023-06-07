/* Given a table of Facebook posts, for each user who posted at least twice in 2021, 
write a query to find the number of days between each user’s first post of the year 
and last post of the year in the year 2021. Output the user and number of the days 
between each user's first and last post */

SELECT 
	user_id, 
    MAX(post_date::date)- MIN(post_date::date) AS days_between
FROM
	posts
WHERE
	DATE_PART('year',post_date::date)=2021 
GROUP BY 
	user_id
HAVING 
	COUNT(post_id)>1
;

/* Write a query to identify the top 2 Power Users who sent the highest number of messages 
on Microsoft Teams in August 2022. Display the IDs of these 2 users along with the total number 
of messages they sent. Output the results in descending order based on the count of the messages.*/

SELECT 
    sender_id, COUNT(DISTINCT message_id) AS total_message
FROM
    messages
WHERE
    EXTRACT(MONTH FROM sent_date) = '8'
        AND EXTRACT(YEAR FROM sent_date) = '2022'
GROUP BY sender_id
HAVING COUNT(DISTINCT message_id) > 2
ORDER BY total_message DESC
;

/* Assume you're given the tables containing completed trade orders and user details 
in a Robinhood trading system. Write a query to retrieve the top three cities that have the highest number 
of completed trade orders listed in descending order. Output the city name and the corresponding number 
of completed trade orders. */

SELECT 
    u.city, COUNT(DISTINCT t.quantity) AS total_quantity
FROM
    trades AS t
        LEFT JOIN
    users AS u ON t.user_id = u.user_id
WHERE
    status = 'Completed'
GROUP BY u.city
ORDER BY total_quantity DESC
LIMIT '3'
;