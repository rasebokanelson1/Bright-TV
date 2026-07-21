-- Databricks notebook source
--------------------------------------------
-- Specifiying which cataog and schema to draw data from
------------------------------------------------
USE bright_tv.data;

--------------------------------------------
-- Retrieving data tables
---------------------------------------------
SELECT *
FROM user_profiles;

SELECT *
FROM viewership;

------------------------------------------------
-- Gender checks
------------------------------------------------
SELECT DISTINCT Gender
FROM user_profiles;

SELECT DISTINCT
    CASE
    WHEN Gender = 'None' THEN 'unknown'
    WHEN Gender = ' ' THEN 'unknown'
    ELSE Gender
    END AS gender_clean
FROM user_profiles;

-------------------------------------
-- Race checks
-------------------------------------
SELECT DISTINCT Race
FROM user_profiles;

SELECT DISTINCT 
    CASE
    WHEN Race = 'other' THEN 'unknown'
    WHEN Race = 'None' THEN 'unknown'
    WHEN Race = ' ' THEN 'unknown'
    ELSE Race
    END AS race_clean
FROM user_profiles;

---------------------------------------
-- DATE FUNCTIONS
----------------------------------------
CREATE TEMPORARY TABLE nelson AS (
SELECT COUNT(DISTINCT UserID0) AS number_of_subs,
    RecordDate2,
    TO_DATE(RecordDate2) AS watch_date,
    DAYNAME(TO_DATE(RecordDate2)) AS day_name,
    CASE
    WHEN DAYNAME(TO_DATE(RecordDate2)) IN ('Sat', 'Sun') THEN '02. Weekend'
    ELSE '01. Weekday'
    END AS day_classification,
    MONTHNAME(TO_DATE(RecordDate2)) AS month_name,
    YEAR(TO_DATE(RecordDate2)) AS event_year,
    DAY(TO_DATE(RecordDate2)) AS event_dt
FROM viewership
WHERE UserID0 IS NOT NULL
GROUP BY ALL
ORDER BY watch_date DESC);

SELECT *
FROM nelson;




