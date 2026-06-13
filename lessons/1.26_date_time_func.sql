SELECT 
    EXTRACT(YEAR FROM job_posted_date) AS year_posted,
    EXTRACT(MONTH FROM job_posted_date) AS month_posted,
    COUNT(*)
FROM job_postings_fact
GROUP BY EXTRACT(YEAR FROM job_posted_date), EXTRACT(MONTH FROM job_posted_date)
ORDER BY year_posted, month_posted;



SELECT 
    DATE_TRUNC('month', job_posted_date) AS month_posted,
    COUNT(*)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024
GROUP BY DATE_TRUNC('month', job_posted_date)
ORDER BY month_posted;

SELECT 
    '2026-01-01 00:00:00+00'::TIMESTAMPTZ AT TIME ZONE 'CST'
;


SELECT
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'
FROM job_postings_fact
LIMIT 20;
