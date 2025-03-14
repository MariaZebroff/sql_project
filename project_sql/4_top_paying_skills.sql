

SELECT 
    skills AS skill_name,
    ROUND(AVG(salary_year_avg), 2) as avg_sal
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
GROUP BY skill_name
ORDER BY avg_sal DESC
LIMIT 25