CREATE TEMP TABLE jobs_2023 AS
SELECT * EXCLUDE(job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;


CREATE TEMP TABLE jobs_2024 AS
SELECT * EXCLUDE(job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;

SELECT * FROM jobs_2024;



SELECT * FROM jobs_2023
UNION
SELECT * FROM jobs_2024;

SELECT * FROM jobs_2023
INTERSECT
SELECT * FROM jobs_2024;

SELECT * FROM jobs_2023
EXCEPT ALL
SELECT * FROM jobs_2024;



SELECT 
    'jobs_2023' AS year,
    COUNT(*) AS record_count
FROM jobs_2023
UNION
SELECT 
    'jobs_2024' AS year,
    COUNT(*)
FROM jobs_2024;