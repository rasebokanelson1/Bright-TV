-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## **USER PROFILES DATA PROCESSING**

-- COMMAND ----------

--------------------------------------------
-- Specifiying which cataog and schema to draw data from
------------------------------------------------
USE bright_tv.data;

--------------------------------------------
-- Retrieving data tables
---------------------------------------------
SELECT *
FROM user_profiles;

--------------------------------------------
-- UserID Checks
---------------------------------------------

SELECT COUNT(*) AS number_of_rows,
        COUNT(DISTINCT UserID) AS number_of_users
FROM user_profiles; --Checking the size of the data

SELECT COUNT(*) AS userid_nulls_count
FROM user_profiles
WHERE UserID IS NULL; --Checking for NULLS. Result = Zero NULLS.

SELECT DISTINCT UserID,
        COUNT(*) AS duplicate_count
FROM user_profiles
GROUP BY UserID
HAVING duplicate_count > 1; --Checking for users duplicates. Result = No duplicates.

--------------------------------------------
-- Gender Checks
---------------------------------------------

SELECT DISTINCT Gender
FROM user_profiles;

SELECT COUNT(*) AS gender_nulls_count
FROM user_profiles
WHERE Gender IS NULL;

--Results show that some rows have 'None' and empty cells, and zero NULL cells. Query below fixes the issue and groups those as 'Unknown'.

SELECT DISTINCT
    CASE
    WHEN Gender = 'None' THEN 'unknown'
    WHEN TRIM(Gender) = '' THEN 'unknown'
    ELSE Gender
    END AS Gender_clean
FROM user_profiles;

--------------------------------------------
-- Age Checks
---------------------------------------------

SELECT DISTINCT Age
FROM user_profiles;

SELECT COUNT(*) AS age_nulls_count
FROM user_profiles
WHERE Age IS NULL;

--Results show that the age column is clean. Age will then be structured into different groups for better context.

SELECT MIN(Age) AS youngest_user,
        MAX(Age) AS oldest_user
FROM user_profiles; --This seeks to find out the youngest and oldest users.

SELECT Age,
    CASE 
    WHEN age = 0 THEN '1. Infants'
    WHEN age BETWEEN 1 AND 12 THEN '2. Kids'
    WHEN age BETWEEN 13 AND 19 THEN '3. Teenager'
    WHEN age BETWEEN 20 AND 35 THEN '4. Youth'
    WHEN age BETWEEN 36 AND 50 THEN '5. Adult'
    WHEN age BETWEEN 51 AND 65 THEN '6. Elder'
    WHEN age >65 THEN '7. Pensioner'
    END AS Age_group
FROM user_profiles; --Structuring age into different groups

------------------------------------

SELECT COUNT(*) AS total_zero_age
FROM user_profiles
WHERE Age = 0;-- 920 users found. Cause for concern/ further investigation.

SELECT COUNT(*) AS total_over_hundred_age
FROM user_profiles
WHERE Age > 100; --7 users found.


--------------------------------------------
-- Province Checks
---------------------------------------------

SELECT DISTINCT Province
FROM user_profiles;

SELECT COUNT(*) AS province_nulls_count
FROM user_profiles
WHERE Province IS NULL; --Zero NULLS.

--Results show that some rows have 'None' and empty cells, and zero NULL cells. Query below fixes the issue and groups those as 'uncategorized'.

SELECT DISTINCT
    CASE 
    WHEN Province = 'None' THEN 'Uncategorized'
    WHEN TRIM(Province) = '' THEN 'Uncategorized'
    ELSE Province
    END AS Province_clean
FROM user_profiles;


--------------------------------------------
-- Race Checks
---------------------------------------------

SELECT DISTINCT Race
FROM user_profiles;

SELECT COUNT(*) AS race_nulls_count
FROM user_profiles
WHERE Race IS NULL;

--Results show that some rows have 'None' and empty cells, and zero NULL cells. Query below fixes the issue and groups those as 'unknown'.

SELECT DISTINCT
    CASE 
    WHEN Race = 'None' THEN 'unknown'
    WHEN TRIM(Race) = '' THEN 'unknown'
    ELSE Race
    END AS Race_clean
FROM user_profiles;

--------------------------------------------
-- Gender Checks
---------------------------------------------

SELECT DISTINCT Gender
FROM user_profiles;

SELECT COUNT(*) AS gender_nulls_count
FROM user_profiles
WHERE Gender IS NULL;

--Results show that some rows have 'None' and empty cells, and zero NULL cells. Query below fixes the issue and groups those as 'Unknown'.

SELECT DISTINCT
    CASE
    WHEN Gender = 'None' THEN 'unknown'
    WHEN TRIM(Gender) = '' THEN 'unknown'
    ELSE Gender
    END AS Gender_clean
FROM user_profiles;

--------------------------------------------
-- Age Checks
---------------------------------------------

SELECT DISTINCT Age
FROM user_profiles;

SELECT COUNT(*) AS age_nulls_count
FROM user_profiles
WHERE Age IS NULL;

--Results show that the age column is clean. Age will then be structured into different groups for better context.

SELECT MIN(Age) AS youngest_user, -- 0
        MAX(Age) AS oldest_user -- 114
FROM user_profiles; --This seeks to find out the youngest and oldest users.

SELECT Age,
    CASE 
    WHEN age = 0 THEN '1. Infants'
    WHEN age BETWEEN 1 AND 12 THEN '2. Kids'
    WHEN age BETWEEN 13 AND 19 THEN '3. Teenager'
    WHEN age BETWEEN 20 AND 35 THEN '4. Youth'
    WHEN age BETWEEN 36 AND 50 THEN '5. Adult'
    WHEN age BETWEEN 51 AND 65 THEN '6. Elder'
    WHEN age >65 THEN '7. Pensioner'
    END AS age_groups
FROM user_profiles; --Structuring age into different groups

------------------------------------

SELECT COUNT(*) AS total_zero_age
FROM user_profiles
WHERE Age = 0;-- 920 users aged 0 years found. NOTE: Cause for concern/ further investigation.

SELECT COUNT(*) AS total_over_hundred_age
FROM user_profiles
WHERE Age > 100; --7 users aged over 100 years found.


--------------------------------------------
-- Province Checks
---------------------------------------------

SELECT DISTINCT Province
FROM user_profiles;

SELECT COUNT(*) AS province_nulls_count
FROM user_profiles
WHERE Province IS NULL; --Zero NULLS.

--Results show that some rows have 'None' and empty cells, and zero NULL cells. Query below fixes the issue and groups those as 'uncategorized'.

SELECT DISTINCT
    CASE 
    WHEN Province = 'None' THEN 'Uncategorized'
    WHEN TRIM(Province) = '' THEN 'Uncategorized'
    ELSE Province
    END AS Province_clean
FROM user_profiles;

--------------------------------------------
-- Race Checks
---------------------------------------------

SELECT DISTINCT Race
FROM user_profiles;

SELECT COUNT(*) AS race_nulls_count
FROM user_profiles
WHERE Race IS NULL;

--Results show that some rows have 'None' and empty cells, and zero NULL cells. Query below fixes the issue and groups those as 'unknown'.

SELECT DISTINCT
    CASE 
    WHEN Race = 'None' THEN 'unknown'
    WHEN TRIM(Race) = '' THEN 'unknown'
    ELSE Race
    END AS race_clean
FROM user_profiles;


--------------------------------------------
-- Social Media Checks
---------------------------------------------

SELECT `Social Media Handle`
FROM user_profiles
WHERE `Social Media Handle` = 'None' OR `Social Media Handle` = ' '; --Checking for "None" and empty cells. Result= There are 'None' cells and no empty cells.

SELECT COUNT(*) AS total_none_cells
FROM user_profiles
WHERE `Social Media Handle` = 'None';-- 920 users found with 'None' cells.

SELECT `Social Media Handle`
FROM user_profiles
WHERE `Social Media Handle` IS NULL; -- Checking for NULLS. Result= Zero NULLS.

SELECT `Social Media Handle`,
    CASE
    WHEN `Social Media Handle`='None' OR TRIM(`Social Media Handle`) = ' '
    THEN 'No'
    ELSE 'Yes'
    END AS Has_Social_Media
FROM user_profiles; -- Flagging users with or without social media handle.

------------------------------------------------
--Matching Users/ Age vs Social Media Handle
------------------------------------------------

SELECT COUNT(*) AS matching_users
FROM user_profiles
WHERE Age = 0 AND `Social Media Handle` = 'None'; -- 918 Users who are aged 0 and have 'None'/ no social media handle.

SELECT *
FROM user_profiles
WHERE Age = 0 AND `Social Media Handle` <> 'None'; -- 2 other users aged 0 years have a social media handle.


------------------------------------------------
--Email Checks
------------------------------------------------

SELECT Email,
COUNT (*) AS total_email_count
FROM user_profiles
GROUP BY Email
ORDER BY total_email_count DESC;-- Checking how many times the same email address was used. Result= There are plenty.

SELECT Email,
        COUNT(*) AS total_same_email
FROM user_profiles
WHERE Email = 'Hugh14@abcmail.com'
GROUP BY Email;-- Example of how many times the same email address was used. Result= 26 (highest count) same email was used 26 times. 

SELECT DISTINCT UserID,
        Name,
        Surname
FROM user_profiles
WHERE Email = 'Hugh14@abcmail.com';-- 26 unique UserIDs linked to one email address. 

SELECT DISTINCT 
        Name,
        Surname
FROM user_profiles
WHERE Email = 'Hugh14@abcmail.com';-- 22 users with unique combination of name and surname linked to one email. This means 4 others share the same name and surname combination.

SELECT *
FROM user_profiles
WHERE Email = 'Hugh14@abcmail.com'; -- Checking what these users with this one email have in common. Result= These are people from different walks of life. Different gender, race, age and province. But here's whats's interesting; they share the same email and social media handle. That raises a serious concern. I mean, no email provider allows same email address and no social media platform allows same username. It can't be that they've all used 26 different social media platforms. Therefore, we can't confidently rely on Email and Social Media Handle columns for analysis.

SELECT Email,
       `Social Media Handle`,
       COUNT(*) AS users
FROM user_profiles
GROUP BY Email, `Social Media Handle`
HAVING users > 1
ORDER BY users DESC;-- This shows the total number of users sharing same email and social media handle. Result= 299 rows have these duplicates and as a result, this further reinforces the idea that the two columns can't be used for analysis with high level of confidence.



























-- COMMAND ----------

-- MAGIC %md
-- MAGIC # **VIEWERSHIP DATA PROCESSING**

-- COMMAND ----------

--------------------------------------------
-- Specifiying which catalog and schema to draw data from
------------------------------------------------
USE bright_tv.data;

--------------------------------------------
-- Retrieving data tables
---------------------------------------------
SELECT *
FROM viewership;

--------------------------------------------
-- UserID Checks
---------------------------------------------

SELECT COUNT(*) AS number_of_rows,
        COUNT(DISTINCT UserID0) AS number_of_users
FROM viewership; --Checking the size of the data. Result= users<rows which means some userids repeat and this makes sense because they watch different shows at different times and so will generate more rows. In essence, userids will duplicate.

SELECT COUNT(*) AS userid0_nulls_count
FROM viewership
WHERE UserID0 IS NULL; --Checking for NULLS. Result = Zero NULLS.

SELECT COUNT(*) AS userid4_nulls_count
FROM viewership
WHERE userid4 IS NULL; --Checking for NULLS. Result = Zero NULLS.

SELECT COUNT(*) AS one_userid
FROM viewership
WHERE UserID0 = userid4; --Result:9515 userid's are the same on both columns.

SELECT COUNT(*) AS one_userid
FROM viewership
WHERE UserID0 <> userid4; --485 userid's are not the same on both columns.

SELECT
COALESCE(UserID0, userid4) AS userid
FROM viewership;--This prioritizes userid's from UserID0. I'm okay with this because the discrepancy is lower.

----------------------------------------
--Channel2 Checks
----------------------------------------

SELECT DISTINCT Channel2
FROM viewership; --Checking different unique channels.

SELECT COUNT(*) AS no_of_nulls
FROM viewership
WHERE Channel2 IS NULL;--No NULLS.

SELECT DISTINCT
CASE
WHEN Channel2 IN ('SawSee','Sawsee') THEN 'SawSee'
WHEN Channel2 IN ('SuperSport Live Events','Live on SuperSport', 'Supersport Live Events', 'DStv Events 1') THEN 'Live Events'
ELSE Channel2
END AS channel_clean
FROM viewership; --Fixes SawSee channel name and groups live events.

----------------------------------------
--RecordDate2 Checks
----------------------------------------

SELECT COUNT(*) AS no_of_nulls
FROM viewership
WHERE RecordDate2 IS NULL;--No NULLS.

SELECT RecordDate2,
    from_utc_timestamp(RecordDate2, 'Africa/Johannesburg') AS RecordDate_SAST
FROM viewership
LIMIT 10;--Convert and preview date data. UTC>>SAST.

SELECT MIN(TO_DATE(RecordDate2)) AS start_date,
        MAX(TO_DATE(RecordDate2)) AS end_date
FROM viewership;-- Results show that this is a 3 months' data ranging from 2016 January to 2016 March.

------------------------------------------------------------------------
WITH cleaned_viewership AS (
SELECT *,
    from_utc_timestamp(RecordDate2, 'Africa/Johannesburg') AS RecordDate_SAST
FROM viewership
)

SELECT 
    TO_DATE(RecordDate_SAST) AS watch_date,
    date_format(RecordDate_SAST,'HH:mm:ss') AS watch_time,
    CASE
        WHEN watch_time BETWEEN '00:00:00' AND '05:59:59' THEN '01. Midnight'
        WHEN watch_time BETWEEN '06:00:00' AND '11:59:59' THEN '02. Morning'
        WHEN watch_time BETWEEN '12:00:00' AND '16:59:59' THEN '03. Afternoon'
        WHEN watch_time BETWEEN '17:00:00' AND '23:59:59' THEN '04. Evening'
        END AS time_of_day,
        HOUR(RecordDate_SAST) AS hour_of_day,
    MONTHNAME(RecordDate_SAST) AS month_name,
    DAYNAME(RecordDate_SAST) AS day_name,
    CASE
        WHEN day_name IN ('Sat', 'Sun') THEN 'weekend'
        ELSE 'weekday'
        END AS day_classification
FROM cleaned_viewership;--extracting useful data for possible business questions.


----------------------------------------
--Duration 2 Checks
----------------------------------------

SELECT `Duration 2`
FROM viewership;--previewing the data in the column

SELECT COUNT(*) AS no_of_nulls
FROM viewership
WHERE `Duration 2` IS NULL;--No NULLS.

SELECT DATE_FORMAT(`Duration 2`, 'HH:mm:ss') AS duration,
        CASE
        WHEN duration BETWEEN '00:05:00' AND '00:30:00' THEN '01. Short Session: <30 min'
        WHEN duration BETWEEN '00:30:01' AND '00:59:59' THEN '02. Medium Session: <60 min'
        WHEN duration > '00:59:59' THEN '03. Long Session: >60 min'
        ELSE '04. Brief Session: <5 min'
        END AS screen_time_bucket
FROM viewership;--Extracting duration and creating a screen time bucket


















------------------------------------------
--SIDE INVESTIGATION 
------------------------------------------

SELECT UserID0,
        userid4
FROM viewership
WHERE UserID0 <> userid4;-- previews userids that dont match on both columns. Result= 485.

SELECT UserID0 FROM viewership
EXCEPT
SELECT UserID FROM user_profiles;-- every userid that's in viewership is on user_profiles

SELECT userid4 FROM viewership
EXCEPT
SELECT UserID FROM user_profiles;-- Same thing here; every userid that's in viewership is on user_profiles

SELECT UserID FROM user_profiles
EXCEPT
SELECT UserID0 FROM viewership;-- 989 rows of userids that are on user_profiles are not on viewership.

SELECT UserID FROM user_profiles
EXCEPT
SELECT userid4 FROM viewership;-- 1295 rows of userids that are on user_profiles are not on viewership.

--Conclusion: user_profiles generally has more ids than viewership irrespective of the column between UserID0 and userid4.

--But,
 
SELECT DISTINCT t1.UserID
FROM user_profiles t1
INNER JOIN viewership t2
  ON t1.UserID = t2.UserID0 AND t1.UserID = t2.userid4;-- 4051 rows/ ids match on columns from the two tables.

  --Conclusion: I think we can use these ids for our analysis since they appear on both tables and would be more realiable. I just don't have a clear idea on how we can achieve that but i think it's worth considering.








-- COMMAND ----------

-- MAGIC %md
-- MAGIC # **CLEAN DATA**

-- COMMAND ----------

----------------------------------
--User Profiles clean table
----------------------------------

SELECT UserID,
        Name,
        Surname,
        
        CASE
    WHEN Gender = 'None' THEN 'unknown'
    WHEN TRIM(Gender) = '' THEN 'unknown'
    ELSE Gender
    END AS Gender_clean,
    
    Age,
    
    CASE 
    WHEN age = 0 THEN '1. Infants'
    WHEN age BETWEEN 1 AND 12 THEN '2. Kids'
    WHEN age BETWEEN 13 AND 19 THEN '3. Teenager'
    WHEN age BETWEEN 20 AND 35 THEN '4. Youth'
    WHEN age BETWEEN 36 AND 50 THEN '5. Adult'
    WHEN age BETWEEN 51 AND 65 THEN '6. Elder'
    WHEN age >65 THEN '7. Pensioner'
    END AS Age_group,

    CASE 
    WHEN Province = 'None' THEN 'Uncategorized'
    WHEN TRIM(Province) = '' THEN 'Uncategorized'
    ELSE Province
    END AS Province_clean,

    CASE 
    WHEN Race = 'None' THEN 'unknown'
    WHEN TRIM(Race) = '' THEN 'unknown'
    ELSE Race
    END AS Race_clean,

    CASE
    WHEN `Social Media Handle` = 'None' OR TRIM(`Social Media Handle`) = ' '
    THEN 'No'
    ELSE 'Yes'
    END AS Has_Social_Media

FROM user_profiles;


----------------------------------
--Viewership clean table
----------------------------------


WITH cleaned_viewership AS (

SELECT   UserID0 AS UserID,
        from_utc_timestamp(RecordDate2, 'Africa/Johannesburg') AS RecordDate_SAST,

        CASE
        WHEN Channel2 IN ('SawSee','Sawsee') THEN 'SawSee'
        WHEN Channel2 IN ('SuperSport Live Events','Live on SuperSport', 'Supersport Live Events', 'DStv Events 1') THEN 'Live Events'
         ELSE Channel2
        END AS channel_clean,
        `Duration 2`

FROM viewership )

SELECT
        
        TO_DATE(RecordDate_SAST) AS watch_date,
    date_format(RecordDate_SAST,'HH:mm:ss') AS watch_time,
    CASE
        WHEN watch_time BETWEEN '00:00:00' AND '05:59:59' THEN '01. Midnight'
        WHEN watch_time BETWEEN '06:00:00' AND '11:59:59' THEN '02. Morning'
        WHEN watch_time BETWEEN '12:00:00' AND '16:59:59' THEN '03. Afternoon'
        WHEN watch_time BETWEEN '17:00:00' AND '23:59:59' THEN '04. Evening'
        END AS time_of_day,
        HOUR(RecordDate_SAST) AS hour_of_day,
    MONTHNAME(RecordDate_SAST) AS month_name,
    DAYNAME(RecordDate_SAST) AS day_name,
    CASE
        WHEN day_name IN ('Sat', 'Sun') THEN 'weekend'
        ELSE 'weekday'
        END AS day_classification,

        DATE_FORMAT(`Duration 2`, 'HH:mm:ss') AS duration,
        CASE
        WHEN duration BETWEEN '00:05:00' AND '00:30:00' THEN '01. Short Session: <30 min'
        WHEN duration BETWEEN '00:30:01' AND '00:59:59' THEN '02. Medium Session: <60 min'
        WHEN duration > '00:59:59' THEN '03. Long Session: >60 min'
        ELSE '04. No Session'
        END AS screen_time_bucket

FROM cleaned_viewership;



----------------------------------
--Final Analysis Table
----------------------------------

WITH cleaned_user_profiles AS (

    SELECT UserID,
        CASE
    WHEN Gender = 'None' THEN 'unknown'
    WHEN TRIM(Gender) = '' THEN 'unknown'
    ELSE Gender
    END AS Gender_Clean,
    
    Age,
    
    CASE 
    WHEN age = 0 THEN '1. Infants'
    WHEN age BETWEEN 1 AND 12 THEN '2. Kids'
    WHEN age BETWEEN 13 AND 19 THEN '3. Teenager'
    WHEN age BETWEEN 20 AND 35 THEN '4. Youth'
    WHEN age BETWEEN 36 AND 50 THEN '5. Adult'
    WHEN age BETWEEN 51 AND 65 THEN '6. Elder'
    WHEN age >65 THEN '7. Pensioner'
    END AS Age_Group,

    CASE 
    WHEN Province = 'None' THEN 'Uncategorized'
    WHEN TRIM(Province) = '' THEN 'Uncategorized'
    ELSE Province
    END AS Province_Clean,

    CASE 
    WHEN Race = 'None' THEN 'unknown'
    WHEN TRIM(Race) = '' THEN 'unknown'
    ELSE Race
    END AS Race_Clean,

    CASE
    WHEN `Social Media Handle` = 'None' OR TRIM(`Social Media Handle`) = ' '
    THEN 'No'
    ELSE 'Yes'
    END AS Has_Social_Media

FROM user_profiles

),

cleaned_viewership AS (

    WITH cleaned_viewership AS (

SELECT   UserID0 AS UserID,
        from_utc_timestamp(RecordDate2, 'Africa/Johannesburg') AS RecordDate_SAST,

        CASE
        WHEN Channel2 IN ('SawSee','Sawsee') THEN 'SawSee'
        WHEN Channel2 IN ('SuperSport Live Events','Live on SuperSport', 'Supersport Live Events', 'DStv Events 1') THEN 'Live Events'
         ELSE Channel2
        END AS Channel_Clean,
        `Duration 2`

FROM viewership )

SELECT
        UserID,
        RecordDate_SAST,
        Channel_Clean,
        TO_DATE(RecordDate_SAST) AS Watch_Date,
    DATE_FORMAT(RecordDate_SAST,'HH:mm:ss') AS Watch_Time,
    CASE
        WHEN watch_time BETWEEN '00:00:00' AND '05:59:59' THEN '01. Midnight'
        WHEN watch_time BETWEEN '06:00:00' AND '11:59:59' THEN '02. Morning'
        WHEN watch_time BETWEEN '12:00:00' AND '16:59:59' THEN '03. Afternoon'
        WHEN watch_time BETWEEN '17:00:00' AND '23:59:59' THEN '04. Evening'
        END AS Time_Of_Day,
        HOUR(RecordDate_SAST) AS Hour_Of_Day,
    MONTHNAME(RecordDate_SAST) AS Month_Name,
    DAYNAME(RecordDate_SAST) AS Day_Name,
    CASE
        WHEN Day_Name IN ('Sat', 'Sun') THEN 'Weekend'
        ELSE 'Weekday'
        END AS Day_Classification,

        DATE_FORMAT(`Duration 2`, 'HH:mm:ss') AS Duration,
        CASE
        WHEN duration BETWEEN '00:05:00' AND '00:30:00' THEN '01. Short Session: <30 min'
        WHEN duration BETWEEN '00:30:01' AND '00:59:59' THEN '02. Medium Session: <60 min'
        WHEN duration > '00:59:59' THEN '03. Long Session: >60 min'
        ELSE '04. No Session'
        END AS Screen_Time_Bucket

FROM cleaned_viewership

)

SELECT

    -- User Information
    u.UserID,
    u.Gender_Clean,
    u.Age,
    u.Age_Group,
    u.Province_Clean,
    u.Race_Clean,
    u.Has_Social_Media,

    -- Viewing Information
    v.RecordDate_SAST,
    v.Watch_Date,
    v.Watch_Time,
    v.Hour_Of_Day,
    v.Day_Name,
    v.Day_Classification,
    v.Month_Name,
    v.Time_Of_Day,

    -- Content
    v.Channel_Clean,

    -- Engagement
    v.Duration,
    v.Screen_Time_Bucket

FROM cleaned_viewership v

LEFT JOIN cleaned_user_profiles u
    ON v.UserID = u.UserID;



