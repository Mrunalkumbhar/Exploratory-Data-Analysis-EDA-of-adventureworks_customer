-- =============================================================================================================================================================================
/* Exploratory Data Analysis (EDA) */
-- ==============================================================================================================================================================================
-- Section 1: Customer Overview
-- Q1. How many customers are there?
select count(*) as No_of_customers from adventureworks_customer;
/*Conclusion:

The dataset contains 18,148 customer records, providing a robust 
sample size for customer segmentation, demographic analysis, 
and business intelligence reporting. The dataset is sufficiently 
large to generate meaningful insights and support data-driven 
decision-making.*/
-- Q2. What is the gender distribution?
select Gender,COUNT(*) AS Customer_Count
FROM adventureworks_customer
GROUP BY Gender
ORDER BY Customer_Count DESC;
/*Conclusion:
The customer base is well balanced by gender, 
with 9,235 (50.89%) male and 8,913 (49.11%) female customers. 
This balanced distribution minimizes gender bias in analysis and 
enables fair comparison of customer behavior, purchasing trends, 
and segmentation across both groups.*/
-- Q3. What is the marital status distribution?
SELECT MaritalStatus,COUNT(*) AS Customer_Count
FROM adventureworks_customer
GROUP BY MaritalStatus
ORDER BY Customer_Count DESC;
/* Conclusion:
The dataset shows a slightly higher proportion of married customers 
(54.09%) compared to single customers (45.91%). 
This indicates that married individuals form the largest customer 
 and may represent a key target audience for family-oriented products, services, 
or marketing campaigns.*/
-- Q4. What percentage of customers are Male vs Female?
select Gender,round(count(*)*100.0/
(SELECT COUNT(*) FROM adventureworks_customer), 2) AS Percentage 
from adventureworks_customer
group by Gender;
/*Conclusion:
Gender distribution is nearly equal, with male 
customers accounting for 50.89% and female customers 49.11% 
of the total customer base. This balanced demographic allows 
for unbiased customer analytics and supports inclusive business 
strategies.*/
-- Q5. What percentage of customers are Married vs Single?
select maritalstatus,count(*) as Customer_Count, round(count(*)*100.0/(select count(*) from adventureworks_customer),2) AS Percentage
from adventureworks_customer
group by maritalstatus; 
/*Conclusion:
Married customers represent the majority (54.09%) 
of the customer base, while 45.91% are single. 
This suggests that marketing strategies focused on households, 
family-oriented products, and long-term customer relationships 
could have a broader reach within this dataset.*/
-- Q6. What percentage of customers are Homeowners vs Non-Homeowners?
select homeowner,count(*) as Customer_Count,round(count(*)*100.0/(select count(*)
from adventureworks_customer),2) as Percentage from adventureworks_customer
group by HomeOwner;
/*Conclusion:

The analysis shows the distribution of customers based on home ownership.
It helps identify the proportion of homeowners versus non-homeowners within the 
customer base.
This information is useful for customer segmentation, targeted marketing campaigns
,and understanding purchasing behavior, as homeowners often exhibit different 
buying patterns compared to non-homeowners.
*/
-- Q7. Which occupation has the highest number of customers?
select Occupation,count(*) as highest_number_of_customers from adventureworks_customer
group by Occupation
order by highest_number_of_customers desc;
/*Conclusion:

The results rank customer occupations from highest to lowest based on the number 
of customers.The occupation appearing at the top represents the largest customer 
segment in the dataset.Understanding the dominant occupation helps businesses 
design targeted marketing strategies, personalize product recommendations, 
and identify key customer demographics for future campaigns
*/
-- Q8. How many unique occupations are represented in the dataset?
select count(distinct Occupation) as Customer_Count from adventureworks_customer;

-- Q9. How many unique education levels are represented in the dataset?
select count(distinct educationlevel) as Customer_Count from adventureworks_customer;
-- Q13. Which education level has the highest number of customers?
select educationlevel,count(*) as Customer_Count from adventureworks_customer
group by EducationLevel
order by Customer_Count desc
limit 1;
-- Q10. What is the distribution of customers by education level?
select educationlevel,count(*) as Customer_Count from adventureworks_customer
group by EducationLevel
order by Customer_Count desc;
-- Q11. What percentage of customers belong to each education level?
select educationlevel,round(count(*)*100.0/(select count(*) from adventureworks_customer),2)
as Customer_Count from adventureworks_customer
group by EducationLevel
order by Customer_Count desc;
-- ============================================================================================
-- Age Analysis
-- ============================================================================================
alter table adventureworks_customer add column Age int;
update adventureworks_customer set age=timestampdiff(Year,birthdate,curdate());
select FirstName,BirthDate,age from adventureworks_customer;
-- Q1. What is the minimum, maximum, and average age?
select min(age)as minimum_age,max(age) as maximum_age,avg(age) as average_age 
from adventureworks_customer;
-- Q2. Create age groups (40–49, 50–59, 60–69, 70+).
select 
case 
when age between 40 and 49 then '40-49'
when age between 50 and 59 then '50–59'
when age between 60 and 69 then '60–69'
else '70+'
end as age_groups,
count(*) as customer
from adventureworks_customer 
group by age_groups;

-- Q3. Which age group has the highest number of customers?
select 
case 
when age between 40 and 49 then '40-49'
when age between 50 and 59 then '50–59'
when age between 60 and 69 then '60–69'
else '70+'
end as age_groups,count(*) as highest_number_of_customers
from adventureworks_customer
GROUP BY Age_Groups
order by highest_number_of_customers desc
limit 1;
-- Q4. What is the gender distribution within each age group?
select gender, 
case 
when age between 40 and 49 then '40-49'
when age between 50 and 59 then '50–59'
when age between 60 and 69 then '60–69'
else '70+'
end as age_groups,count(*) as  customer
from adventureworks_customer
group by gender,age_groups
order by gender,age_groups;
-- Q5. Which marital status is most common in each age group?
select MaritalStatus,
case 
when age between 40 and 49 then '40-49'
when age between 50 and 59 then '50–59'
when age between 60 and 69 then '60–69'
else '70+'
end as age_groups,count(*) as  customer
from adventureworks_customer
group by MaritalStatus,age_groups;

-- ================================================================================================================================================================================
/* Income Analysis*/
-- ================================================================================================================================================================================
-- Q11. What are the minimum, maximum, and average annual incomes?
select max(AnnualIncome) as maximum_income,
min(AnnualIncome) as minimum_income,
round(avg(AnnualIncome),2) as average_annual_incomes 
from adventureworks_customer;
-- Q12. Which customers have the highest annual income?
select * from adventureworks_customer
where AnnualIncome=
(select max(AnnualIncome) from adventureworks_customer);
-- Q13. Which occupation has the highest average income?
select occupation,round(avg(AnnualIncome),2) as highest_average_income 
from adventureworks_customer
group by occupation
order by highest_average_income desc
limit 1  ;
-- Q14. Which education level has the highest average income?
select EducationLevel,round(avg(AnnualIncome),2) as highest_average_income
from adventureworks_customer
group by EducationLevel
order by highest_average_income desc
limit 1;
-- Q15. Compare average income between males and females.
select Gender,round(avg(AnnualIncome),2) AS Average_Income from adventureworks_customer
group by Gender;
-- Q16. Compare average income between married and single customers.
select MaritalStatus,round(avg(AnnualIncome),2) AS Average_Income from adventureworks_customer
group by MaritalStatus;
-- Q17. Create income groups:
--        Less than $30K
--        $30K–$60K
--        $60K–$90K
--        Above $90K
select 
case
 when AnnualIncome<30000 then 'Less than $30K'
 when AnnualIncome between 30000 and 60000 then '$30K–$60K'
 when AnnualIncome between 60001 and 90000 then '$60K–$90K'
 else 'Above $90K' 
 end as income_groups,
 count(*) AS Customer_Count
FROM adventureworks_customer
GROUP BY income_groups
ORDER BY Customer_Count DESC;

-- ==========================================================================================================================================
/* Section 4: Education Analysis*/
-- ==========================================================================================================================================
-- Q18. How many customers belong to each education level?
select educationlevel,count(*) as No_customers from adventureworks_customer
group by educationlevel;
-- Q19. Which education level is the most common?
select educationlevel,count(*) as No_customers from adventureworks_customer
group by educationlevel
order by No_customers desc
limit 1;
-- Q20. What is the average income by education level?
select EducationLevel,round(avg(AnnualIncome),2) as average_income from adventureworks_customer
group by educationlevel;
-- Q21. What is the gender distribution by education level?
select EducationLevel,gender,count(*) as No_customers from adventureworks_customer
group by EducationLevel,gender;

-- ==============================================================================================================================================
/* Occupation Analysis */
-- ==============================================================================================================================================
-- Q22. How many customers belong to each occupation?
select Occupation ,count(*) as No_customers from adventureworks_customer
group by Occupation;
-- Q23. Which occupation has the highest average income?
select occupation,round(avg(AnnualIncome),2)as highest_average_income from adventureworks_customer
group by occupation
order by highest_average_income desc
limit 1;
-- Q24. Which occupation has the highest number of homeowners?
select occupation,count(*) as highest_number_of_homeowners from adventureworks_customer
where HomeOwner='Y'
group by Occupation
order by highest_number_of_homeowners desc;
-- Q25. What is the average number of children by occupation?
select occupation,round(avg(TotalChildren),0) as average_number_of_children from adventureworks_customer
group by Occupation;

-- ========================================================================================================================================================================================
/* Home Ownership Analysis */
-- =========================================================================================================================================================================================
-- Q26. What percentage of customers own a home?
SELECT HomeOwner,COUNT(*) AS Total_Customers,ROUND(COUNT(*) * 100.0 /
(SELECT COUNT(*) FROM adventureworks_customer),2) AS Percentage FROM adventureworks_customer
GROUP BY HomeOwner;
-- Q27. Compare homeowner status by gender.
select homeowner,gender,count(*) as Compare_homeowner from adventureworks_customer
group by homeowner,gender ;
-- Q28. Compare homeowner status by marital status.
select homeowner,MaritalStatus,count(*) as Compare_homeowner from adventureworks_customer
group by homeowner,MaritalStatus ;
-- Q29. Compare average income of homeowners vs non-homeowners.
select homeowner,round(avg(annualincome),0) from adventureworks_customer
group by homeowner;


