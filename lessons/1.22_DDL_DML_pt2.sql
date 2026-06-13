CREATE OR REPLACE TABLE staging.job_postings_flat AS
SELECT 
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_work_from_home,
    jpf.job_posted_date,
    jpf.job_country,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.company_id,
    cd.name
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
ON jpf.company_id = cd.company_id;

SELECT *
FROM staging.job_postings_flat
LIMIT 10;

CREATE OR REPLACE VIEW staging.job_postings_flat_view AS
SELECT
    *
FROM staging.job_postings_flat AS jpf
JOIN staging.priority_roles AS pr 
ON jpf.job_title_short = pr.role_name
WHERE pr.priority_lvl = 1;

SELECT
    jpfv.job_title_short,
    COUNT(*)

FROM staging.job_postings_flat_view AS jpfv
GROUP BY jpfv.job_title_short
ORDER BY COUNT(*) DESC;


CREATE OR REPLACE TEMPORARY TABLE senior_job_flat_temp AS
SELECT *
FROM staging.job_postings_flat_view AS jpfv
WHERE jpfv.job_title_short = 'Senior Data Engineer';

SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.job_postings_flat_view;
SELECT COUNT(*) FROM senior_job_flat_temp;

DELETE FROM staging.job_postings_flat
WHERE job_posted_date < '2024-1-1';


SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.job_postings_flat_view;
SELECT COUNT(*) FROM senior_job_flat_temp;

TRUNCATE TABLE staging.job_postings_flat;

INSERT INTO staging.job_postings_flat
SELECT 
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_work_from_home,
    jpf.job_posted_date,
    jpf.job_country,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.company_id,
    cd.name
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
ON jpf.company_id = cd.company_id
WHERE jpf.job_posted_date > '2024-1-1';

SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.job_postings_flat_view;
SELECT COUNT(*) FROM senior_job_flat_temp;