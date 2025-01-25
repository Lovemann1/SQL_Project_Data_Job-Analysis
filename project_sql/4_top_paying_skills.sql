select skills_dim.skills,
    round(avg(salary_year_avg), 0) as avg_salary_per_skill
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
    and salary_year_avg is not NULL
GROUP BY skills
ORDER BY avg_salary_per_skill DESC
