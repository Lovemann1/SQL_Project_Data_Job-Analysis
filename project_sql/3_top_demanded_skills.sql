select
     skills,
    count(job_postings_fact.job_id) as totel_demand
from
     job_postings_fact
INNER JOIN
     skills_job_dim ON
    job_postings_fact.job_id = skills_job_dim.job_id
inner join
     skills_dim on 
    skills_dim.skill_id = skills_job_dim.skill_id
WHERE
     job_title_short LIKE 'Data Analyst'
GROUP BY skills
ORDER BY totel_demand DESC
LIMIT 5;