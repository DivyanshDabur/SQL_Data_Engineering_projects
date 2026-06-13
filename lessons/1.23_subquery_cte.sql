SELECT *
FROM
    (
        SELECT *
        FROM job_postings_fact
        WHERE salary_hour_avg IS NOT NULL
        OR salary_year_avg IS NOT NULL
    )
LIMIT 10;


WITH valid_salaries AS (
    SELECT *
    FROM job_postings_fact
    WHERE salary_hour_avg IS NOT NULL
    OR salary_year_avg IS NOT NULL
)
SELECT * 
FROM valid_salaries;



SELECT 
    job_title_short,
    salary_year_avg,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
    ) AS market_median_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;



SELECT 
    job_title_short,
    MEDIAN(salary_year_avg) AS median_remote_salry,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS market_median_remote_salary
FROM (
    SELECT 
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
)
GROUP BY job_title_short
LIMIT 10;



SELECT 
    job_title_short,
    MEDIAN(salary_year_avg) AS median_remote_salry,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS market_median_remote_salary
FROM (
    SELECT 
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
)
GROUP BY job_title_short
HAVING MEDIAN(salary_year_avg) > (
    SELECT MEDIAN(salary_year_avg)
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE   
)
LIMIT 10;

WITH cte_table AS(
    SELECT 
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg)::INT AS median_salary
    FROM job_postings_fact
    GROUP BY job_title_short, job_work_from_home
)
SELECT 
    r.job_title_short,
    r.median_salary AS median_remote_salry,
    o.median_salary AS median_onsite_salry,
    (median_remote_salry - median_onsite_salry) AS remote_margin
FROM cte_table AS r
JOIN cte_table AS o 
ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE 
AND o.job_work_from_home = FALSE
ORDER BY remote_margin DESC;


SELECT *
FROM job_postings_fact AS tgt
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_job_dim AS src
    WHERE src.job_id = tgt.job_id
)
ORDER BY job_id;

DESCRIBE skills_dim;