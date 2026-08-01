# 📺 BrightTV Viewership Analytics Case Study

## Project Overview

This project explores user demographics and viewership behaviour for **BrightTV**, a subscription-based television platform. The objective was to analyse customer and viewing data to uncover actionable insights that support the company's goal of growing its subscription base.

Using SQL in Databricks, the raw datasets were inspected, cleaned, transformed and integrated into a single analytical dataset. The final dataset was then analysed using Microsoft Excel through pivot tables and visualisations to identify user trends, consumption patterns and factors influencing viewer engagement.

---

## Business Problem

BrightTV's Chief Executive Officer (CEO) aims to increase the company's subscription base during the current financial year. To support this objective, the Customer Value Management (CVM) team requires data-driven insights into customer behaviour and content consumption.

The analysis was designed to answer the following business questions:

* Who are BrightTV's users?
* How do subscribers consume content on the platform?
* Which factors influence content consumption?
* What content strategies could increase engagement on low-consumption days?
* What initiatives could support subscriber growth?

---

## Dataset

The case study consists of two datasets:

### User Profiles

Contains subscriber demographic information, including:

* User ID
* Gender
* Age
* Province
* Race
* Email
* Social Media Handle

### Viewership

Contains individual viewing sessions for each subscriber, including:

* User ID
* Viewing Channel
* Viewing Date and Time (UTC)
* Session Duration

Each record in the Viewership dataset represents **one viewing session**.

---

## Project Workflow

The project followed a structured analytics workflow:

1. Business Understanding
2. Data Inspection
3. Data Cleaning
4. Data Transformation
5. Exploratory Data Analysis (EDA)
6. Data Visualisation
7. Business Insights
8. Strategic Recommendations

---

## Data Preparation

Several preprocessing steps were completed before analysis:

### User Profiles

* Checked for duplicate User IDs.
* Validated missing and inconsistent values.
* Standardised Gender, Race and Province categories.
* Created Age Groups.
* Created a Social Media indicator.
* Investigated data quality issues such as unrealistic ages and duplicated contact information.

### Viewership

* Standardised channel names.
* Converted timestamps from **UTC** to **South African Standard Time (SAST)**.
* Extracted additional date and time attributes including:

  * Watch Date
  * Watch Time
  * Hour of Day
  * Day of Week
  * Month
  * Time of Day
* Categorised viewing sessions into screen time buckets.
* Integrated cleaned viewership and user profile datasets into a single analytical table.

---

## Key Areas of Analysis

The analysis focused on three primary themes:

### 1. Understanding BrightTV Users

* Gender distribution
* Age distribution
* Provincial distribution
* Race distribution
* Social media presence

### 2. Understanding Viewing Behaviour

* Most watched channels
* Consumption by time of day
* Consumption by day of week
* Monthly consumption trends
* Screen time distribution

### 3. Factors Influencing Consumption

* Age vs Channel Preference
* Province vs Channel Preference
* Time of Day vs Channel Consumption

---

## Tools Used

* **Databricks SQL** - Data inspection, cleaning and transformation
* **Microsoft Excel** - Pivot tables, dashboards and visualisations
* **GitHub** - Project documentation and version control

---

## Key Deliverables

* Cleaned analytical dataset
* SQL data preparation scripts
* Pivot tables and visualisations
* Business insights
* Executive recommendations
* Presentation for business stakeholders

---

## Outcome

The project demonstrates an end-to-end analytics workflow, from raw data inspection through to business recommendations. The findings provide actionable insights into subscriber demographics, viewing behaviour and content consumption patterns, enabling BrightTV to make informed decisions around customer engagement, content strategy and subscriber growth.
