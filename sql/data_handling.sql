use data_scientist_project;

-- 1.a)
-- selecting a table from student_purchases while adding a 
-- column with date end details
SELECT 
    s.purchase_id,
    s.student_id,
    s.plan_id,
    s.date_purchased AS date_start,
    s.date_refunded,
    CASE   -- Start of CASE statement to handle different subscription plan durations
        WHEN plan_id = 0 THEN DATE_ADD(date_purchased, INTERVAL 1 MONTH)
        WHEN plan_id = 1 THEN DATE_ADD(date_purchased, INTERVAL 3 MONTH)
        WHEN plan_id = 2 THEN DATE_ADD(date_purchased, INTERVAL 12 MONTH)
        WHEN plan_id = 3 THEN CURDATE()
    END AS date_end
FROM
    student_purchases s
ORDER BY student_id;

-- 1.b)
-- Modifying date_end to date_refunded if a refund is happening
SELECT  
    purchase_id,
    student_id,
    plan_id,
    date_start,
    IF (date_refunded IS NULL, date_end, date_refunded) AS date_end
FROM
    (
        -- Inner Subquery (Derived Table)
        SELECT  
            s.purchase_id,
            s.student_id,
            s.plan_id,
            s.date_purchased AS date_start,
            s.date_refunded,
            CASE  -- Start of CASE statement to handle different subscription plan durations
                -- Using MONTH instead of DAY for correct month arithmetic
                WHEN plan_id = 0 THEN DATE_ADD(s.date_purchased, INTERVAL 1 MONTH) 
                WHEN plan_id = 1 THEN DATE_ADD(s.date_purchased, INTERVAL 3 MONTH)
                WHEN plan_id = 2 THEN DATE_ADD(s.date_purchased, INTERVAL 12 MONTH)
                WHEN plan_id = 3 THEN CURDATE()
            END AS date_end
        FROM
            student_purchases s
    ) AS a; 


-- 2)
-- Creating a view
DROP VIEW IF EXISTS purchases_info;
CREATE OR REPLACE VIEW purchases_info AS
    SELECT 
       *,
        CASE
            WHEN date_end < '2021-04-01' THEN 0
            WHEN date_start > '2021-06-30' THEN 0
            ELSE 1
        END AS paid_q2_2021,
        CASE
            WHEN date_end < '2022-04-01' THEN 0
            WHEN date_start > '2022-06-30' THEN 0
            ELSE 1
        END AS paid_q2_2022
    FROM
        (SELECT 
            purchase_id,
                student_id,
                plan_id,
                date_start,
                IF(date_refunded IS NULL, date_end, date_refunded) AS date_end
        FROM
            (SELECT 
            s.purchase_id,
                s.student_id,
                s.plan_id,
                s.date_purchased AS date_start,
                s.date_refunded,
                CASE
                    WHEN plan_id = 0 THEN DATE_ADD(s.date_purchased, INTERVAL 1 MONTH)
                    WHEN plan_id = 1 THEN DATE_ADD(s.date_purchased, INTERVAL 3 MONTH)
                    WHEN plan_id = 2 THEN DATE_ADD(s.date_purchased, INTERVAL 12 MONTH)
                    WHEN plan_id = 3 THEN CURDATE()
                END AS date_end
        FROM
            student_purchases s) AS a) AS b;

-- Verifying view table values --		
 SELECT 
    *
FROM
    purchases_info
where 
	paid_q2_2021 =1
order by student_id;

-- 3)
-- generating a list of students along with their 
-- minutes_watched values in Q2 2021
SELECT 
    student_id,
    round(sum(seconds_watched) / 60,2) AS minutes_watched
FROM
    student_video_watched
WHERE
    date_watched BETWEEN '2021-04-01' AND '2021-06-30'
GROUP BY student_id;



SELECT 
    student_id,
    round(sum(seconds_watched) / 60,2) AS minutes_watched
FROM
    student_video_watched
WHERE
    date_watched BETWEEN '2022-04-01' AND '2022-06-30'
GROUP BY student_id;

-- --------
SELECT 
  a.student_id, 
  a.minutes_watched, 
  IF(
    min(i.date_start) IS NULL, -- Check if the student has a start date in purchases_info
    0, 
    MAX(i.paid_q2_2021) -- !!! Change to *_2021 or *_2022 depending on the year considered !!!
  ) AS paid_in_q2 
FROM 
  (
	-- Subquery to get total minutes watched by each student for a specific year
    SELECT 
      student_id, 
      
      -- Convert total seconds watched to minutes and round to 2 decimal places
      ROUND(
        SUM(seconds_watched) / 60, 
        2
      ) AS minutes_watched 
    FROM 
      student_video_watched 
    WHERE 
      date_watched BETWEEN '2021-04-01' AND '2021-06-30'-- !!! Ensure consistency with paid_q2 year !!!
    GROUP BY 
      student_id
  ) a 
  LEFT JOIN purchases_info i ON a.student_id = i.student_id 
GROUP BY 
  student_id
HAVING paid_in_q2 = 0 ;-- !!! Change to 0 or 1 based on desired filter !!!;
-- ------------------
--         2022 --
-- ------------------
SELECT 
  a.student_id, 
  a.minutes_watched, 
  IF(
    min(i.date_start) IS NULL, -- Check if the student has a start date in purchases_info
    0, 
    MAX(i.paid_q2_2022) -- !!! Change to *_2021 or *_2022 depending on the year considered !!!
  ) AS paid_in_q2 
FROM 
  (
	-- Subquery to get total minutes watched by each student for a specific year
    SELECT 
      student_id, 
      
      -- Convert total seconds watched to minutes and round to 2 decimal places
      ROUND(
        SUM(seconds_watched) / 60, 
        2
      ) AS minutes_watched 
    FROM 
      student_video_watched 
    WHERE 
      date_watched BETWEEN '2022-04-01' AND '2022-06-30'-- !!! Ensure consistency with paid_q2 year !!!
    GROUP BY 
      student_id
  ) a 
  LEFT JOIN purchases_info i ON a.student_id = i.student_id 
GROUP BY 
  student_id
HAVING paid_in_q2 = 0; -- !!! Change to 0 or 1 based on desired filter !!!;

-- -------------------------------------------------
-- student -  minutes watched - certificates issued
-- --------------------------------------------------
SELECT 
    student_id,
    count(certificate_id) as certificates_issued
FROM
    student_certificates
group by student_id;

-- ------------------------------------------------------------------------
--  query provides a complete list of students, 
-- showing their certificate count and their total watch time, 
-- with a default of 0 for those who haven't watched any videos.
-- --------------------------------------------------------------------------
Select
		a.student_id,
		a.certificates_issued,
        ROUND(
        COALESCE(SUM(seconds_watched),0) / 60, 
        2
      ) AS minutes_watched 
from
		(
            SELECT
                student_id,
                COUNT(certificate_id) AS certificates_issued
            FROM
                student_certificates
            GROUP BY
                student_id
        ) a
-- Use LEFT JOIN to keep all students from 'a'
LEFT JOIN
    student_video_watched w
ON
    a.student_id = w.student_id
GROUP BY
    a.student_id,
    a.certificates_issued
ORDER BY
    a.student_id;

-- --------------------------------------------------------
--  Calculating the number of students who watched a lecture in Q2 2021
SELECT 
    COUNT(DISTINCT student_id)
FROM
    student_video_watched
WHERE
    YEAR(date_watched) = 2021;
    
    
    
-- Calculating the number of students who watched a lecture in Q2 2022
SELECT 
    COUNT(DISTINCT student_id)
FROM
    student_video_watched
WHERE
    YEAR(date_watched) = 2022;
    
    
    
-- Calculating the number of students who watched a lecture in Q2 2021 and Q2 2022
SELECT 
    COUNT(DISTINCT student_id)
FROM
    (
    -- Subquery to get unique students who watched lectures in 2021
    SELECT DISTINCT
        student_id
    FROM
        student_video_watched
    WHERE
        YEAR(date_watched) = 2021) a -- Alias for the subquery results for 2021
	-- Join with another subquery to get students who also watched videos in 2022
	JOIN 
    (
    -- Subquery to get unique students who watched videos in 2022
    SELECT DISTINCT
        student_id
    FROM
        student_video_watched
    WHERE
        YEAR(date_watched) = 2022) b -- Alias for the subquery results for 2022
	-- Specify the common column (student_id) for joining the results of the two subqueries
	USING(student_id);
    
    
        
-- Calculating the total number of students who watched a lecture
SELECT 
    COUNT(DISTINCT student_id)
FROM
    student_video_watched;