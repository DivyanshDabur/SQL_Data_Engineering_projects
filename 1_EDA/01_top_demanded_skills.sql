/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

SELECT
    COUNT(jpf.*) AS count_of_skill,
    sd.skills
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
        ON sd.skill_id = sjd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
GROUP BY sd.skills
ORDER BY COUNT(jpf.*) DESC
LIMIT 10;

/*
┌────────────────┬────────────┐
│ count_of_skill │   skills   │
│     int64      │  varchar   │
├────────────────┼────────────┤
│         233132 │ sql        │
│         224102 │ python     │
│         130205 │ aws        │
│         128822 │ azure      │
│         106904 │ spark      │
│          69657 │ java       │
│          63012 │ databricks │
│          60379 │ snowflake  │
│          57079 │ scala      │
│          56410 │ kafka      │
└────────────────┴────────────┘
  10 rows           2 columns
*/
