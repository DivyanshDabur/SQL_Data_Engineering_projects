SELECT 
    job_id,
    COUNT(*) OVER ()
FROM job_postings_fact;

SELECT 
    job_id,
    job_title_short,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short
    )
FROM job_postings_fact;



SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK() OVER (
        ORDER BY salary_hour_avg DESC
    )
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL;



SELECT 
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short
        ORDER BY job_posted_date 
    ) AS running_avg_title
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY job_title_short, job_posted_date;



SELECT 
    company_id,
    job_posted_date,
    job_title_short,
    salary_year_avg,
    LAG(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date 
    ) AS prev_avg_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY company_id, job_posted_date
;