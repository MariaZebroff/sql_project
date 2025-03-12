SELECT name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM 
        job_postings_fact
    WHERE
        job_no_degree_mention = true
)

WITH company_jobs_count AS (
SELECT 
    company_id,
    COUNT(*) AS count_jobs
FROM 
    job_postings_fact
GROUP BY company_id
)

SELECT name,
company_jobs_count.count_jobs
FROM company_dim
LEFT JOIN company_jobs_count ON company_jobs_count.company_id = company_dim.company_id
ORDER BY company_jobs_count.count_jobs DESC

WITH remote_job_skills AS (
SELECT skill_id,
COUNT(*) AS skill_count
FROM skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id =  skills_to_job.job_id
WHERE job_postings.job_work_from_home = True AND
job_postings.job_title_short = 'Data Analyst'
Group BY skill_id
) SELECT skills.skill_id, skills AS skill_name, skill_count FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id  =  remote_job_skills.skill_id
ORDER BY  skill_count DESC
LIMIT 5

SELECT * FROM january_jobs

WITH av_job_sal AS (SELECT job_title_short, salary_year_avg, job_posted_date FROM january_jobs
UNION ALL
SELECT job_title_short, salary_year_avg, job_posted_date FROM february_jobs
UNION ALL
SELECT job_title_short, salary_year_avg, job_posted_date FROM march_jobs
) SELECT * FROM av_job_sal 
WHERE salary_year_avg > 70000

SELECT * FROM (
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
) AS quater1_job_postings WHERE salary_year_avg > 70000