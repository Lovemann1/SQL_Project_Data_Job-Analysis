# Indroduction
Exprore the data job market of 2023! focusing on
Data Analyst role, This project explores top-paying
job, in-demant skills, and find the skills which is
payed the most in the Data Analyst role.
- For **SQL queries** click here: [project_sql folder](/project_sql/) 
# Background
This project was inspired by my desire to better understand
the role of a Data Analyst and other data-related professions.
As someone keen on entering the world of data, I sought to
uncover the key skills and insights necessary for excelling
in this field.

Using SQL, I analyzed datasets related to:

Job postings in data-related domains.

Skill requirements commonly mentioned
for roles such as Data Analyst, Data Scientist, and Business Analyst.
Data is located in [SQL Course](https://github.com/Lovemann1/SQL_Project_Data_Job-Analysis)
### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst job ?
2. What skills are required for these top-paying jobs ?
3. what skills are the most in demand for data analyst ?
4. which skills are associated with higher salaries?
5. What are the most optimal skill to learn?
# Tools I used 
In my way of getting the inside from the data analyst job maket in had to use these following tools;

- **SQL:**  The backbone of all my analyst, allowing me to query the database and providing the critical insights.
- **postgreSQL:** The chosen database managment system, ideal for handling the job posting data
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

- **Power Shell:** Assisted me to connect with public repository and made it easy for me to pull and push file from Git Hub.
# The Analysis
Each query in the project was aimed at to find specific inside from the data set. and design to answer the question that I mention above
here are how I approched each question;
### 1. Top paying Data Analyst Jobs
 To find highest paying jobs I filtered data anlalyst positions by average yearly salary, and had to get company name from a separate table by join clause.

``` SQL 
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
LIMIT 10 
```
Here is the brackdown of the top data analyst job in 2023
- **Wide Salary Range** Top 10 paying data analyst role span from $184,000 to $650,000 indicating singnificant salary potential in the field.
- **Dicerse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries.
![Top paying Roles](Assets\image_1.png) 




### 2.Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers valuse for high-compensation roles.

``` SQL
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
 ```
 Here's is breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023 
 - **SQL** is leading with a bold count of 8
 - **Python** follows closely with a bold count of 7
 ![skill count of top paying jobs ](Assets\2_top_paying_roles_skills.png)

 ### 3. In-Demand Skills for Data Analysts
  This query halped identify the skills most frequently requested in job postings, directing focus to area with high demand.
  ```SQL
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
```
Here is the breakdown of the most demanded skills for data analysts in 2023
- SQL and Excel remain fundamental
- Programming and Visualization Tools like Python,Tableau, and Power Bi are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills    | Total Demand |
|-----------|--------------|
| SQL       | 92,628       |
| Excel     | 67,031       |
| Python    | 57,326       |
| Tableau   | 46,554       |
| Power BI  | 39,468       |

Table of the demand for the top 5 skills in data analyst job postings

### 4. Skills Based on Salary 
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
``` SQL 
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
ORDER BY avg_salary_per_skill 
LIMIT 25;
```
Here is a breakdown of the results for top paying skills for data analyst :
- High Demand for Big Data & ML  skills: Top salaries are commanded by analysts skilled in big data technologies ,machine learing tools (DataRobot, Jupter), and Python libraries (Pandas, Numpy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- Cloud Computing Experties: Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environmets, suggesting that cloud proficienct significantly boosts earning potential in data analystics.


| Skills          | Avg Salary per Skill |
|------------------|----------------------|
| SVN             | 400,000             |
| Solidity        | 179,000             |
| Couchbase       | 160,515             |
| DataRobot       | 155,486             |
| GoLang          | 155,000             |
| MXNet           | 149,000             |
| dplyr           | 147,633             |
| VMware          | 147,500             |
| Terraform       | 146,734             |
| Twilio          | 138,500             |
| GitLab          | 134,126             |
| Kafka           | 129,999             |
| Puppet          | 129,820             |
| Keras           | 127,013             |
| PyTorch         | 125,226             |

### 5. Most Optimal Skills to learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries offering a strategic focus for skill development.
```SQL
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count,
    round(avg(job_postings_fact.salary_year_avg), 0) as avg_salary
FROM
     job_postings_fact
INNER JOIN
     skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
     skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg is not NULL
GROUP BY
    skills_dim.skill_id
HAVING
    count(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
| Skill ID | Skills       | Demand Count | Avg Salary |
|----------|--------------|--------------|------------|
| 98       | Kafka        | 40           | 129,999    |
| 101      | PyTorch      | 20           | 125,226    |
| 31       | Perl         | 20           | 124,686    |
| 99       | TensorFlow   | 24           | 120,647    |
| 63       | Cassandra    | 11           | 118,407    |
| 219      | Atlassian    | 15           | 117,966    |
| 96       | Airflow      | 71           | 116,387    |
| 3        | Scala        | 59           | 115,480    |
| 169      | Linux        | 58           | 114,883    |
| 234      | Confluence   | 62           | 114,153    |
| 95       | PySpark      | 49           | 114,058    |
| 18       | MongoDB      | 26           | 113,608    |
| 62       | MongoDB      | 26           | 113,608    |
| 81       | GCP          | 78           | 113,065    |
| 92       | Spark        | 187          | 113,002    |
| 193      | Splunk       | 15           | 112,928    |
| 75       | Databricks   | 102          | 112,881    |
| 210      | Git          | 74           | 112,250    |
| 80       | Snowflake    | 241          | 111,578    |
| 6        | Shell        | 44           | 111,496    |
| 168      | Unix         | 37           | 111,123    |
| 97       | Hadoop       | 140          | 110,888    |
| 93       | Pandas       | 90           | 110,767    |

Table of the most optimal skills for Data Analyst sorted by salary 
Here is the breakdown of hte most optimal skills for Data Analysts in 2023
- High-Demand Programming Languages: python and R stand out for their high demand with demand count of 236 and 148 respectively with the salery of $101,397 and $100,499.
- Cloud Tools and Technologies: Skills in specilized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries. 

# What I learn 
This was the first learning projact for me every minute that I spent in bulding this project was a learning exprience for me. This project helped me to under sql query more deeply. Provided me a chance to implement new skills that I learned along the way
# Conclusion
1. **Top-Paying Data Analyst Jobs:** The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs:** High-paying data analyst jobs require advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In-Demand Skills:** SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries:** Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers for a high average salary, positioning it as one most optimal skills for data analyst to learn to maximize their market value.
