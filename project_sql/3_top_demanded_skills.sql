SELECT 
    skills_dim.skills AS skill_name,
    COUNT(job_postings_fact.job_id) as job_amount
FROM 
    job_postings_fact
LEFT JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY skills_dim.skill_id
ORDER BY job_amount DESC
LIMIT 5