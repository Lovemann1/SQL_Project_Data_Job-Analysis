with top_paying_job_with_job_id as (
    SELECT job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        company_dim.name
    from
         job_postings_fact
    left join
         company_dim on
        job_postings_fact.company_id = company_dim.company_id
    where
         job_title_short = 'Data Analyst'
        and salary_year_avg IS NOT NULL 
        --and job_location = 'Anywhere'
    ORDER BY
         salary_year_avg DESC
    LIMIT 10)
SELECT 
    top_paying_job_with_job_id.job_id,
    top_paying_job_with_job_id.job_title,
    top_paying_job_with_job_id.job_location,
    top_paying_job_with_job_id.salary_year_avg,
    top_paying_job_with_job_id.name,
    skills_job_dim.skill_id,
    skills_dim.skills
from
     skills_job_dim
INNER JOIN
     top_paying_job_with_job_id ON
    top_paying_job_with_job_id.job_id = skills_job_dim.job_id
inner join
     skills_dim on 
    skills_dim.skill_id = skills_job_dim.skill_id
order by salary_year_avg