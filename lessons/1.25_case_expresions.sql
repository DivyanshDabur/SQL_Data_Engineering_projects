SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg IS NULL THEN 'not avialable'
        WHEN salary_hour_avg < 25 THEN 'low'
        WHEN salary_hour_avg < 50 THEN 'medium'
        ELSE 'high'
    END AS salary_category
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY RANDOM()
LIMIT 100;



SELECT
    job_title_short,
    job_title,
    CASE
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Analyst%' THEN 'Data Analyst'
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Engineer%' THEN 'Data Engineer'
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Scientist%' THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_category
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 20;



SELECT
    job_title_short,
    COUNT(*),
    MEDIAN(CASE
        WHEN salary_year_avg < 100_000 THEN salary_year_avg
    END) AS low_median_category,
    MEDIAN(CASE
        WHEN salary_year_avg >= 100_000 THEN salary_year_avg
    END) AS high_median_category,
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
;


WITH salaries AS (
SELECT
    job_title_short,
    salary_hour_avg,
    salary_year_avg,
    CASE
        WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
        WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg*2080
    END AS salary_standard
FROM job_postings_fact
)

SELECT *,
    CASE 
        WHEN salary_standard IS NULL THEN 'missing'
        WHEN salary_standard < 75_000 THEN 'low'
        WHEN salary_standard < 150_000 THEN 'low'
        ELSE 'high'
    END AS salary_category
FROM salaries
ORDER BY salary_standard 
LIMIT 20;
