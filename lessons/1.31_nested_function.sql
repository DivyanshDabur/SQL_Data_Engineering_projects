SELECT ['python', 'sql', 'r'] AS skills_arr;

WITH skills AS (
    SELECT 'python' AS skill
    UNION ALL
    SELECT 'sql'
    UNION ALL
    SELECT 'r'
), skills_array AS (
    SELECT LIST(skill ORDER BY skill) AS skills
    FROM skills
)
SELECT 
    skills[1]
FROM skills_array
;


SELECT {skill: 'python', type: 'programming'} AS skill;

SELECT 
    STRUCT_PACK(
        skill := 'python',
        type := 'programming'
    ) AS skill;


WITH skills_table AS (
    SELECT 'python' AS skills, 'programming' AS types
    UNION ALL
    SELECT 'sql', 'query_language'
    UNION ALL
    SELECT 'r', 'programming'
)
SELECT 
    STRUCT_PACK(
        skill := skills,
        type := types
    ) AS skill
FROM skills_table;


WITH skills_table AS (
    SELECT 'python' AS skills, 'programming' AS types
    UNION ALL
    SELECT 'sql', 'query_language'
    UNION ALL
    SELECT 'r', 'programming'
), skill_arr_struct AS(
    SELECT 
        ARRAY_AGG(
            STRUCT_PACK(
                skill := skills,
                type := types
            ) 
        ) AS arr_struct
    FROM skills_table
)
SELECT 
    arr_struct[1].skill,
    arr_struct[2].type,
    arr_struct[3]
FROM skill_arr_struct;




CREATE OR REPLACE TEMP TABLE flat_table AS
SELECT 
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(sd.skills) AS skills
FROM job_postings_fact AS jpf 
LEFT JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
GROUP BY ALL
ORDER BY jpf.job_id;



WITH flat_skill_table AS (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        UNNEST(skills) AS skill
    FROM flat_table
)
SELECT 
    skill,
    MEDIAN(salary_year_avg) AS median_salary
FROM flat_skill_table
GROUP BY skill;



CREATE OR REPLACE TEMP TABLE flat_array_struct AS
SELECT 
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    ARRAY_AGG(
        STRUCT_PACK(
            skill_type := sd.type,
            skill := sd.skills
        )
    ) AS skills
FROM job_postings_fact AS jpf 
LEFT JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
GROUP BY ALL
ORDER BY jpf.job_id;



WITH flat_skill_table AS (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        UNNEST(skills).skill_type AS skill_type,
        UNNEST(skills).skill AS skill
    FROM flat_array_struct
)
SELECT 
    skill_type,
    MEDIAN(salary_year_avg) AS median_salary
FROM flat_skill_table
GROUP BY skill_type;