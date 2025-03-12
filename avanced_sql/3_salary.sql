 SELECT
    AVG(salary_year_avg) AS avg_year_salary_posted_by_month,
    AVG(salary_hour_avg) AS avg_hourly_salary_posted_by_month,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
GROUP BY month
ORDER BY avg_year_salary_posted_by_month DESC;