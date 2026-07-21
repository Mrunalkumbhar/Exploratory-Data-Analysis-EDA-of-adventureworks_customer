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
