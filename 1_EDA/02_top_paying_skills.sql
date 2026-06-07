/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT
    COUNT(jpf.*) AS num_of_jobs,
    sd.skills,
    MEDIAN(jpf.salary_year_avg) AS median_salary
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' AND jpf.job_work_from_home = TRUE
GROUP BY sd.skills
HAVING COUNT(jpf.*) > 100
ORDER BY median_salary DESC
LIMIT 25;

/*
┌─────────────┬────────────┬───────────────┐
│ num_of_jobs │   skills   │ median_salary │
│    int64    │  varchar   │    double     │
├─────────────┼────────────┼───────────────┤
│         232 │ rust       │      210000.0 │
│        3248 │ terraform  │      184000.0 │
│         912 │ golang     │      184000.0 │
│         364 │ spring     │      175500.0 │
│         277 │ neo4j      │      170000.0 │
│         582 │ gdpr       │      169615.5 │
│         127 │ zoom       │      168437.5 │
│         445 │ graphql    │      167500.0 │
│         265 │ mongo      │      162250.0 │
│         204 │ fastapi    │      157500.0 │
│         478 │ bitbucket  │      155000.0 │
│         265 │ django     │      155000.0 │
│         129 │ crystal    │      154223.5 │
│         444 │ c          │      151500.0 │
│         249 │ atlassian  │      151500.0 │
│         388 │ typescript │      151000.0 │
│        4202 │ kubernetes │      150500.0 │
│         736 │ ruby       │      150000.0 │
│         262 │ css        │      150000.0 │
│         179 │ node       │      150000.0 │
│        9996 │ airflow    │      150000.0 │
│         605 │ redis      │      149000.0 │
│         136 │ vmware     │     148798.25 │
│         475 │ ansible    │     148798.25 │
│         400 │ jupyter    │      147500.0 │
└─────────────┴────────────┴───────────────┘
  25 rows                        3 columns
*/