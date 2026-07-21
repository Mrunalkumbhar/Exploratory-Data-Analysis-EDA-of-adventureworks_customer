-- =====================================================
-- Phase 1 : Data Understanding
-- =====================================================

-- Q1. View the complete dataset
SELECT *
FROM adventureworks_customer;

-- Q-2. Check row and column count
select count(*) from adventureworks_customer;

SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'adventureworks_customer';
-- Q3. View table structure
DESCRIBE adventureworks_customer;

-- Q4. Check whether CustomerKey is unique (Primary Key Validation)
SELECT
    CustomerKey,
    COUNT(*) AS record_count
FROM adventureworks_customer
GROUP BY CustomerKey
HAVING COUNT(*) > 1;

-- Q5. View sample records
SELECT *
FROM adventureworks_customer
LIMIT 5;

-- Q6. Count total customers
SELECT
    COUNT(*) AS total_customers
FROM adventureworks_customer;

-- =====================================================
-- Understand Categorical Variables
-- =====================================================

-- Q7. Gender
SELECT DISTINCT Gender
FROM adventureworks_customer;

-- Q8. Marital Status
SELECT DISTINCT MaritalStatus
FROM adventureworks_customer;

-- Q9. Education Level
SELECT DISTINCT EducationLevel
FROM adventureworks_customer;

-- Q10. Occupation
SELECT DISTINCT Occupation
FROM adventureworks_customer;

-- Q11. Home Ownership
SELECT DISTINCT HomeOwner
FROM adventureworks_customer;

-- =====================================================
-- Category Counts
-- =====================================================

-- Q12. Gender Distribution
SELECT
    Gender,
    COUNT(*) AS total_customers
FROM adventureworks_customer
GROUP BY Gender;

-- Q13. Marital Status Distribution
SELECT
    MaritalStatus,
    COUNT(*) AS total_customers
FROM adventureworks_customer
GROUP BY MaritalStatus;

-- Q14. Home Ownership Distribution
SELECT
    HomeOwner,
    COUNT(*) AS total_customers
FROM adventureworks_customer
GROUP BY HomeOwner;

-- Q15. Number of Occupations
SELECT
    COUNT(DISTINCT Occupation) AS total_occupations
FROM adventureworks_customer;

-- Q16. Number of Education Levels
SELECT
    COUNT(DISTINCT EducationLevel) AS total_education_levels
FROM adventureworks_customer;

-- =====================================================
-- Numeric Columns
-- =====================================================

-- Q17. TotalChildren Range
SELECT
    MIN(TotalChildren) AS minimum_children,
    MAX(TotalChildren) AS maximum_children
FROM adventureworks_customer;

-- Q18. Annual Income Range
SELECT
    MIN(AnnualIncome) AS minimum_income,
    MAX(AnnualIncome) AS maximum_income
FROM adventureworks_customer;

-- =====================================================
-- Date Column
-- =====================================================

-- Q19. BirthDate Range
SELECT
    MIN(BirthDate) AS oldest_birth_date,
    MAX(BirthDate) AS youngest_birth_date
FROM adventureworks_customer;

/*
Dataset Name : AdventureWorks Customer

Objective:
Understand customer demographics including
- Gender
- Education
- Occupation
- Income
- Home Ownership
- Birth Date
*/
/* Conclusion:

The initial data understanding phase provided a comprehensive overview of the AdventureWorks Customer dataset. The dataset contains customer demographic information such as gender, marital status, education level, occupation, home ownership, annual income, total children, and birth date.

During this phase:

1.Verified the total number of rows and columns in the dataset.
2.Examined the table structure and identified the available attributes.
3.Confirmed that CustomerKey is unique, indicating it can be used as the primary key.
4.Reviewed sample records to understand the data format and values.
5.Explored all categorical variables and identified their unique categories.
6.Analyzed the distribution of customers across gender, marital status, and home ownership.
7.Determined the number of unique occupations and education levels.
8.Examined the minimum and maximum values of numeric columns such as AnnualIncome and TotalChildren.
9.Identified the range of customer birth dates to understand the age span represented in the dataset.
10.Overall, this phase established a clear understanding of the 
dataset's structure, key attributes, and customer demographics, 
providing a strong foundation for the subsequent Data Cleaning, 
Exploratory Data Analysis (EDA), and Business Insights phases./*

/*================================================================================================
 Phase 2: Data Cleaning 
===================================================================================================
*/
-- Q1. Check for Duplicate Records
select customerkey,count(*) from adventureworks_customer
group by CustomerKey
having count(*)>1;
/*Conclusion :
Verified the uniqueness of the CustomerKey by 
grouping records and identifying duplicate occurrences. 
No duplicate records were found, confirming that each CustomerKey 
is unique and can be reliably used as the primary key for the dataset. 
This ensures data integrity 
and eliminates the need for duplicate record removal.
*/


-- Q2. Check for NULL Values
select 
sum(case when customerkey is null then 1 else 0 end) as customerkey_null,
SUM(CASE WHEN Prefix IS NULL THEN 1 ELSE 0 END) AS Prefix_Null,
SUM(CASE WHEN FirstName IS NULL THEN 1 ELSE 0 END) AS FirstName_Null,
SUM(CASE WHEN LastName IS NULL THEN 1 ELSE 0 END) AS LastName_Null,
SUM(CASE WHEN BirthDate IS NULL THEN 1 ELSE 0 END) AS BirthDate_Null,
SUM(CASE WHEN MaritalStatus IS NULL THEN 1 ELSE 0 END) AS MaritalStatus_Null,
SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null,
SUM(CASE WHEN AnnualIncome IS NULL THEN 1 ELSE 0 END) AS AnnualIncome_Null,
SUM(CASE WHEN TotalChildren IS NULL THEN 1 ELSE 0 END) AS TotalChildren_Null,
SUM(CASE WHEN EducationLevel IS NULL THEN 1 ELSE 0 END) AS EducationLevel_Null,
SUM(CASE WHEN Occupation IS NULL THEN 1 ELSE 0 END) AS Occupation_Null,
SUM(CASE WHEN HomeOwner IS NULL THEN 1 ELSE 0 END) AS HomeOwner_Null
from adventureworks_customer;
/*
Conclusion : Performed a comprehensive check for NULL values across all key columns us
ing conditional aggregation. The analysis confirmed that no NULL 
values were present in the dataset. Since all columns contain complete data, 
no missing value treatment or imputation is required at this stage, 
indicating good data quality 
and consistency.
*/

-- Q3. Check for Blank Values
select * from adventureworks_customer
where trim(FirstName)=''
or trim(LastName)=''
or trim(Occupation)=''
or trim(EducationLevel)='';
/* Conclusion:
No blank values were found in the checked columns 
(FirstName, LastName, Occupation, and EducationLevel). 
This indicates that the dataset has complete text entries for 
these important customer attributes and no additional cleaning is required 
for blank string values.*/

-- Q4. Check for Invalid Gender Values
SELECT DISTINCT Gender FROM adventureworks_customer
WHERE Gender NOT IN ('M', 'F') OR Gender IS NULL;

SELECT *
FROM adventureworks_customer
WHERE Gender = 'NA';
UPDATE adventureworks_customer
SET Gender =
CASE
    WHEN FirstName IN ('WENDY','ANGELA','ANNA','KATHERINE','NAOMI','KATIE','ALISHA','ADRIANA','JASMINE','ALEXA','ROBYN',
'RENEE','TERESA','CATHERINE','NINA','MINDY','ABBY','MICHELE','ANDREA','EMILY','RUTH','AMANDA','MAKAYLA','LATOYA','MISTY','SHEILA',
'ALEXANDRIA','MADISON','RACHEL','EBONY','GLORIA','CANDICE','SHANNON','TAMMY','JENNY','SHEENA','DAISY','JACQUELINE','EMMA','SAVANNAH',
'KRISTI','MARIE','BARBARA','CYNTHIA','JULIA','VANESSA','GAIL','TONYA','LESLIE','TAMARA','KENDRA','CHRISTY','DIANA','CAROLINE','LINDSEY','SAMANTHA'
'ALEXANDRA','CASEY','BRIANNA','MARTHA','NANCY','JAN','JESSIE','KRISTINE')
    THEN 'F'
WHEN FirstName IN ('ALEJANDRO','CESAR','TODD','DARREN','BRANDON','NICOLAS','BENJAMIN','MICAH','RICARDO','HAROLD','MIGUEL','ARTHUR','LEVI','SHAWN','NATHANIEL','NOAH','CEDRIC','KEITH','VINCENT','DOUGLAS',
'RICKY','JOSE','CHRISTIAN','JONATHAN','ORLANDO','FERNANDO','JACK','JASON','JÉSUS','LUIS','GERALD','CHRISTOPHER','JEROME','MARCUS','PEDRO','DENNIS','THOMAS','EDDIE','BRETT','SAMUEL',
'AIDAN','ZACHARY','IAN','BARRY','JAMIE','DALTON','CRAIG','WYATT','NEIL','ALEXANDER','LUKE','EDWARD','RANDALL'
 'REGINALD','LOUIS','FRANKLIN','DEVIN','TERRY','ALEXANDRA','REGINALD'  )
    THEN 'M'

    ELSE Gender
END;
/* Validated the Gender column to ensure it contains only the expected values (M and F). 
The validation identified NA as an invalid value, indicating inconsistent data entry. 
This value should be treated as missing or unknown data and cleaned appropriately before 
further analysis 
to maintain data quality and ensure accurate insights.
*/

-- Q5. Check for Invalid Marital Status
SELECT DISTINCT MaritalStatus FROM adventureworks_customer
where MaritalStatus not in ('M','S') or MaritalStatus is null;
/*Conclusion:
Validated the MaritalStatus column to ensure it contains only the
expected values (M and S). No invalid or NULL values were found,
indicating that the data is clean and consistent for this attribute.*/
-- Q6. Check for Invalid HomeOwner Values
SELECT DISTINCT HomeOwner
FROM adventureworks_customer
WHERE HomeOwner NOT IN ('Y','N')
   OR HomeOwner IS NULL;
/*Conclusion:
Validated the HomeOwner column to ensure it contains only the expected
values (Y and N). No invalid or NULL values were found, confirming
that the HomeOwner field is clean, consistent, and ready for analysis.*/

-- Q7 Convert BirthDate to DATE
SELECT BirthDate,
STR_TO_DATE(BirthDate, '%m/%d/%Y') AS Converted_BirthDate
FROM adventureworks_customer
LIMIT 10;
UPDATE adventureworks_customer
SET BirthDate_New = STR_TO_DATE(BirthDate, '%m/%d/%Y');

ALTER TABLE adventureworks_customer
DROP COLUMN BirthDate;
ALTER TABLE adventureworks_customer
CHANGE BirthDate_New BirthDate DATE;
/*Conclusion:
The BirthDate column was originally stored as TEXT in MM/DD/YYYY 
format. It was successfully converted to the DATE data type using 
STR_TO_DATE(). This enables accurate date operations such as age 
calculation, date filtering, and time-based analysis.
*/
-- Q8. Check for Invalid Birth Dates
select * from adventureworks_customer
where BirthDate>curdate();
/*Conclusion:
No future birth dates were found in the dataset. All customer
birth dates are valid, ensuring the reliability of date-based
analysis such as age calculation and customer segmentation.*/
-- Q9. Check Age Range
SELECT
    MIN(TIMESTAMPDIFF(YEAR, BirthDate, CURDATE())) AS Youngest_Customer_Age,
    MAX(TIMESTAMPDIFF(YEAR, BirthDate, CURDATE())) AS Oldest_Customer_Age
FROM adventureworks_customer;

/* Conclusion: 
Age validation was performed after converting the BirthDate column 
to the DATE data type. The youngest customer is 45 years old, 
while the oldest customer is 115 years old. The results indicate 
that age calculations are working correctly. Since the maximum age 
is unusually high, the oldest records should be reviewed to confirm whether they are valid historical 
customer records or potential data anomalies.*/
-- Q10.Convert AnnualIncome

ALTER TABLE adventureworks_customer
ADD COLUMN AnnualIncome_New INT;

UPDATE adventureworks_customer
SET AnnualIncome_New =
CAST(
    REPLACE(
        REPLACE(
            TRIM(AnnualIncome),
            '$', ''
        ),
        ',', ''
    ) AS UNSIGNED
);


ALTER TABLE adventureworks_customer
DROP COLUMN AnnualIncome;

ALTER TABLE adventureworks_customer
CHANGE AnnualIncome_New AnnualIncome INT;
/*The AnnualIncome column was originally stored as text with 
currency formatting (e.g., $90,000). The values were cleaned by 
removing the dollar sign, commas, and extra spaces using TRIM() 
and REPLACE(), then converted to the INT data type using CAST(). 
This conversion enables accurate numerical analysis such as 
calculating minimum, maximum, average income, and performing income-based segmentation.
*/
-- Q11. Check for Negative Income
SELECT * FROM adventureworks_customer
WHERE AnnualIncome < 0;
/*Conclusion:
Conclusion:
No negative income values were found in the AnnualIncome column.
All income records contain valid positive values, confirming that
the column is suitable for numerical and financial analysis..
*/
-- 
-- Q12 Check Income Range
SELECT
    MIN(AnnualIncome) AS Minimum_Income,
    MAX(AnnualIncome) AS Maximum_Income,
    AVG(AnnualIncome) AS Average_Income
FROM adventureworks_customer;
/*
Conclusion:
After converting the AnnualIncome column from TEXT to INT,
descriptive statistics were calculated successfully.
The analysis shows that customer annual income ranges from
$10,000 to $170,000, with an average annual income of
approximately $57,269.12.
No negative or invalid income values were identified,
indicating that the AnnualIncome column is clean and suitable
for further income-based analysis and customer segmentation.*/
-- Q13. Check for Negative Children Count
SELECT * FROM adventureworks_customer
WHERE TotalChildren < 0;
/*Conclusion:
No negative values were found in the TotalChildren column. 
The data is valid and consistent, as all customer records have
realistic children count values.*/

-- Q14. Check for Duplicate Customers by Name and Birth Date
SELECT FirstName,LastName,BirthDate,
    COUNT(*) AS record_count
FROM adventureworks_customer
GROUP BY FirstName, LastName, BirthDate
HAVING COUNT(*) > 1;


/*Conclusion:
"Duplicate record validation was performed using the 
combination of FirstName, LastName, and BirthDate. 
The query returned no records, indicating that no duplicate 
customer entries were found based on these attributes. 
The dataset maintains uniqueness and consistency."*/
/*====================================================
Phase 2 Summary : Data Cleaning
======================================================

✔ Verified CustomerKey uniqueness (No duplicate records)

✔ Confirmed no NULL values in critical columns.

✔ Confirmed no blank values in important text fields.

✔ Validated categorical variables:
   • Gender
   • MaritalStatus
   • HomeOwner

✔ Converted BirthDate from TEXT to DATE.

✔ Converted AnnualIncome from TEXT to INT.

✔ Verified:
   • No future birth dates
   • No negative income values
   • No negative TotalChildren values
   • No duplicate customer records

Result:
The dataset is clean, consistent, and ready for
Exploratory Data Analysis (EDA).
*/
-- =============================================================================================================================================================================
/* Exploratory Data Analysis (EDA) */
-- ==============================================================================================================================================================================
-- Section 1: Customer Overview
-- Q1. How many customers are there?
select count(*) as No_of_customers from adventureworks_customer;
-- Q2. What is the gender distribution?
select distinct gender from adventureworks_customer;
-- Q3. What is the marital status distribution?
select distinct maritalstatus from adventureworks_customer;
-- Q4. What percentage of customers are Male vs Female?
select Gender,round(count(*)*100.0/
(SELECT COUNT(*) FROM adventureworks_customer), 2) AS Percentage 
from adventureworks_customer
group by Gender;
-- Q5. What percentage of customers are Married vs Single?
select maritalstatus,count(*) as Maritalstatus, round(count(*)*100.0/(select count(*) 
from adventureworks_customer),2) AS Percentage
group by maritalstatus; 