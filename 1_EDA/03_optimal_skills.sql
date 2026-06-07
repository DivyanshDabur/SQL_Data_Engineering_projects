/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/


SELECT
    sd.skills,
    COUNT(jpf.*) AS num_of_jobs,
    ROUND(MEDIAN(jpf.salary_year_avg), 2) AS median_salary,
    ROUND(LN(COUNT(jpf.*)), 2) AS ln_num_of_jobs,
    ROUND((median_salary*ln_num_of_jobs)/10_00_000, 2) AS optimal_score

FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sd.skill_id = sjd.skill_id
WHERE jpf.job_title_short = 'Data Engineer' AND jpf.job_work_from_home = TRUE AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING COUNT(jpf.*) > 100
ORDER BY optimal_score DESC
LIMIT 25;

/*
┌────────────┬─────────────┬───────────────┬────────────────┬───────────────┐
│   skills   │ num_of_jobs │ median_salary │ ln_num_of_jobs │ optimal_score │
│  varchar   │    int64    │    double     │     double     │    double     │
├────────────┼─────────────┼───────────────┼────────────────┼───────────────┤
│ terraform  │         193 │      184000.0 │           5.26 │          0.97 │
│ python     │        1133 │      135000.0 │           7.03 │          0.95 │
│ sql        │        1128 │      130000.0 │           7.03 │          0.91 │
│ aws        │         783 │     137320.31 │           6.66 │          0.91 │
│ airflow    │         386 │      150000.0 │           5.96 │          0.89 │
│ spark      │         503 │      140000.0 │           6.22 │          0.87 │
│ snowflake  │         438 │      135500.0 │           6.08 │          0.82 │
│ kafka      │         292 │      145000.0 │           5.68 │          0.82 │
│ azure      │         475 │      128000.0 │           6.16 │          0.79 │
│ java       │         303 │      135000.0 │           5.71 │          0.77 │
│ scala      │         247 │     137290.48 │           5.51 │          0.76 │
│ kubernetes │         147 │      150500.0 │           4.99 │          0.75 │
│ git        │         208 │      140000.0 │           5.34 │          0.75 │
│ databricks │         266 │      132750.0 │           5.58 │          0.74 │
│ redshift   │         274 │      130000.0 │           5.61 │          0.73 │
│ gcp        │         196 │      136000.0 │           5.28 │          0.72 │
│ nosql      │         193 │      134415.0 │           5.26 │          0.71 │
│ hadoop     │         198 │      135000.0 │           5.29 │          0.71 │
│ pyspark    │         152 │      140000.0 │           5.02 │           0.7 │
│ mongodb    │         136 │      135750.0 │           4.91 │          0.67 │
│ docker     │         144 │      135000.0 │           4.97 │          0.67 │
│ go         │         113 │      140000.0 │           4.73 │          0.66 │
│ r          │         133 │      134775.0 │           4.89 │          0.66 │
│ github     │         127 │      135000.0 │           4.84 │          0.65 │
│ bigquery   │         123 │      135000.0 │           4.81 │          0.65 │
└────────────┴─────────────┴───────────────┴────────────────┴───────────────┘
 25 rows                                                         5 columns
*/
