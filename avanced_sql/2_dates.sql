SELECT job_posted_date
From job_postings_fact LIMIT 10;


SELECT job_title_short AS title,
job_location AS location,
job_posted_date::DATE AS date 
FROM job_postings_fact;

--Transfering zone from UTC to EST knowing that data collected in UTC

SELECT job_title_short AS title,
job_location AS location,
job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact LIMIT 5;

SELECT job_title_short AS title,
job_location AS location,
job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 9
 LIMIT 5;

 SELECT
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
GROUP BY month
ORDER BY job_count;