WITH skills_damand AS (SELECT
skills_job_dim.skill_id, 
skills_dim.skills as skills,
    COUNT(job_postings_fact.job_id) as job_amount
FROM 
    job_postings_fact
LEFT JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL 
GROUP BY skills_job_dim.skill_id, skills_dim.skills
), averege_salary AS (
    SELECT 
    skills_job_dim.skill_id, 

    ROUND(AVG(salary_year_avg), 2) as avg_sal
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
GROUP BY skills_job_dim.skill_id


)

SELECT skills_damand.skill_id,
skills_damand.skills,
job_amount,
avg_sal
FROM skills_damand
INNER JOIN averege_salary ON averege_salary.skill_id = skills_damand.skill_id
ORDER BY job_amount DESC,
avg_sal DESC 
LIMIT 25