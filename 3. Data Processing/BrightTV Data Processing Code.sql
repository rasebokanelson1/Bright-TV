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
    END AS age_groups
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
    END AS race_clean
FROM user_profiles;


--------------------------------------------
-- Social Media Checks
---------------------------------------------

SELECT DISTINCT `Social Media Handle`
FROM user_profiles;

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
    END AS age_groups
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
    END AS race_clean
FROM user_profiles;


--------------------------------------------
-- Social Media Checks
---------------------------------------------

SELECT DISTINCT `Social Media Handle`
FROM user_profiles;

SELECT `Social Media Handle`
FROM user_profiles
WHERE `Social Media Handle` = 'None' OR `Social Media Handle` = ' ';

SELECT `Social Media Handle`
FROM user_profiles
WHERE `Social Media Handle` IS NULL; -- Checking for NULLS. Result= Zero NULLS.

SELECT `Social Media Handle`,
    CASE 
    WHEN `Social Media Handle` IS NOT NULL THEN 'Yes'
    ELSE 'No'
    END AS Has_Social_Media
FROM user_profiles;

--MATCHING THE USERS

SELECT COUNT(*) AS matching_users
FROM user_profiles
WHERE Age = 0 AND `Social Media Handle` = 'None';

SELECT COUNT(*) AS matching_users
FROM user_profiles
WHERE `Social Media Handle` = ' ';


SELECT Age,
        `Social Media Handle`
FROM user_profiles
WHERE Age = 0 AND `Social Media Handle` = 'None';

SELECT *
FROM user_profiles
WHERE Age = 0
  AND `Social Media Handle` <> 'None';
















