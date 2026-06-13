SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_catalog = 'data_jobs';

PRAGMA show_tables_expanded;

DESCRIBE table

SELECT 
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
FROM job_postings_fact AS jpf
LEFT jOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
LIMIT 10;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sd.skills,
    sd.type,
    sjd.skill_id
FROM job_postings_fact AS jpf
LEFT JOIN  skills_job_dim AS sjd
ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
ON sjd.skill_id = sd.skill_id; 


    SELECT
        cd.name,
        COUNT(jpf.job_id) AS num_of_jobs
    FROM job_postings_fact AS jpf
    LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
    WHERE jpf.job_country = 'United States'
    GROUP BY cd.name
    HAVING COUNT(jpf.job_id) > 3000
    ORDER BY num_of_jobs DESC;
