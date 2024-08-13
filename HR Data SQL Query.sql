--Check attrition rate and attrition percentage by department
select department, count(attrition) as attrition_count, round((cast(count(attrition)as numeric)/(select count(attrition) from hrdata where attrition = 'Yes'))*100,2) as attrion_percentage
from hrdata 
where attrition = 'Yes'
group by department
order by attrition_count desc

--Check Number of Employee by age
select age, count(employee_count) as employee_count
from hrdata
group by age
order by age

--Check Education field wise attrition
select education_field, count(attrition)
from hrdata
where attrition = 'Yes'
group by education_field
order by count(attrition) desc

--Check attrition rate by gender for different age group
select gender, age_band, count(attrition) as attrition, round((cast(count(attrition)as numeric)/(select count(attrition) from hrdata where attrition = 'Yes'))*100,2) as attrition_percentage
from hrdata
where attrition = 'Yes'
group by gender,age_band
order by age_band

---Check Job Satisfaction by job role
CREATE EXTENSION IF NOT EXISTS tablefunc

SELECT *
FROM crosstab(
  'SELECT job_role, job_satisfaction, sum(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction'
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;
