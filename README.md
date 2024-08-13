# HR Data Analysis Dashboard

## Table of Contents
1. [Introduction](#1-introduction)
2. [Project Overview](#2-project-overview)
3. [Objectives](#3-objectives)
4. [Data Source and Database Setup](#4-data-source-and-database-setup)
5. [Dashboard Development in Tableau](#5-dashboard-development-in-tableau)
6. [Quality Assurance and Validation](#6-quality-assurance-and-validation)
7. [Key Features and Visualizations](#7-key-features-and-visualizations)
8. [SQL Validation Queries](#8-sql-validation-queries)
9. [Conclusion and Future Scope](#9-conclusion-and-future-scope)

## 1. Introduction

In today's data-driven business landscape, Human Resources (HR) departments are increasingly leveraging analytics to make informed decisions about their workforce. The HR Data Analysis Dashboard project aims to transform raw HR data into actionable insights, enabling our organization to optimize workforce management, improve employee satisfaction, and make data-driven HR decisions.

## 2. Project Overview

This project involves the creation of an interactive HR Analytics Dashboard using Tableau, with data stored and validated using PostgreSQL. The dashboard provides a comprehensive view of key HR metrics, including employee demographics, attrition patterns, job satisfaction levels, and departmental insights.

## 3. Objectives

- Enhance decision-making processes in HR management
- Improve employee retention strategies through data-driven insights
- Optimize workforce planning and resource allocation
- Increase transparency in HR metrics across the organization
- Enable proactive management of potential HR issues
- Support strategic initiatives related to employee engagement and satisfaction

## 4. Data Source and Database Setup

### 4.1 Data Source
The project utilizes a comprehensive HR dataset containing various employee attributes and performance indicators.

### 4.2 PostgreSQL Database Setup

We created a dedicated HR Database in PostgreSQL with the following schema:

```sql
CREATE TABLE hrdata (
    emp_no int8 PRIMARY KEY,
    gender varchar(50) NOT NULL,
    marital_status varchar(50),
    age_band varchar(50),
    age int8,
    department varchar(50),
    education varchar(50),
    education_field varchar(50),
    job_role varchar(50),
    business_travel varchar(50),
    employee_count int8,
    attrition varchar(50),
    attrition_label varchar(50),
    job_satisfaction int8,
    active_employee int8
);
```

## 5. Dashboard Development in Tableau

The HR Analytics Dashboard was created in Tableau following these steps:

1. Data Connection: Connected Tableau to the PostgreSQL database.
2. Data Preparation: Cleaned and structured the data for analysis.
3. Dashboard Layout Design: Designed the overall layout and color scheme.
4. Visualization Creation: Developed individual charts and graphs for each HR metric.
5. Interactivity Implementation: Added filters and action filters for dynamic data exploration.
6. Performance Optimization: Ensured efficient data retrieval and dashboard responsiveness.

## 6. Quality Assurance and Validation

Our QA process involves three main components:

1. Functional Validation: Testing each dashboard feature and filter.
2. Data Validation: Comparing dashboard data with SQL query results.
3. Test Documentation: Creating a comprehensive test document with screenshots and SQL queries.

## 7. Key Features and Visualizations

The dashboard includes the following key features and visualizations:

1. Employee Count
2. Attrition Count
3. Attrition Rate
4. Active Employees
5. Average Age
6. Department-wise Attrition (Pie Chart)
7. Number of Employees by Age Group (Histogram)
8. Education Field-wise Attrition (Bar Chart)
9. Attrition Rate by Gender for Different Age Groups (Donut Charts)
10. Job Satisfaction Rating (Heat Map)

## 8. SQL Validation Queries

To ensure data accuracy, we use the following SQL queries for validation:

### 8.1 Attrition Rate and Percentage by Department

```sql
SELECT department, COUNT(attrition) AS attrition_count, 
       ROUND((CAST(COUNT(attrition) AS NUMERIC)/(SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes'))*100,2) 
       AS attrion_percentage
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY department
ORDER BY attrition_count DESC;
```

### 8.2 Number of Employees by Age

```sql
SELECT age, COUNT(employee_count) AS employee_count
FROM hrdata
GROUP BY age
ORDER BY age;
```

### 8.3 Education Field-wise Attrition

```sql
SELECT education_field, COUNT(attrition)
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY education_field
ORDER BY COUNT(attrition) DESC;
```

### 8.4 Attrition Rate by Gender for Different Age Groups

```sql
SELECT gender, age_band, COUNT(attrition) AS attrition, 
       ROUND((CAST(COUNT(attrition) AS NUMERIC)/(SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes'))*100,2) 
       AS attrition_percentage
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY gender, age_band
ORDER BY age_band;
```

### 8.5 Job Satisfaction by Job Role

```sql
CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT *
FROM crosstab(
  'SELECT job_role, job_satisfaction, SUM(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction'
) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;
```

## 9. Conclusion and Future Scope

The HR Data Analysis Dashboard provides a powerful tool for HR professionals to gain insights into workforce dynamics, identify trends, and make data-driven decisions. By leveraging Tableau's visualization capabilities and PostgreSQL's robust data management, we've created a solution that enhances HR operations and supports strategic workforce planning.

Future enhancements may include:
- Predictive analytics for attrition risk
- Integration with real-time data sources
- Advanced machine learning models for talent management
- Expansion to include additional HR metrics and KPIs

This project lays the foundation for continued data-driven HR management, positioning our organization to better understand, engage, and retain our valuable human resources.
