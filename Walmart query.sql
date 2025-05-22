-- DROP DATABASE IF EXISTS  `Walmart_Analysis`;
CREATE DATABASE `Walmart_Analysis`;
USE `Walmart_Analysis`;

-- Table was imported directly and a new table was created to keep the raw data intact incase of errors
RENAME  TABLE `walmartsalesdata.csv` TO walmart_rawdata;

-- Creation of New table
DROP TABLE IF EXISTS Walmart_sales;
CREATE TABLE Walmart_sales
LIKE Walmart_rawdata;

--  MODIFICATION OF DATA TYPES
ALTER TABLE Walmart_sales
MODIFY TOTAL_2 DECIMAL(7,3) NOT NULL ;

-- Renaming of Columns names
ALTER TABLE walmart_sales
RENAME COLUMN `Total` TO Revenue;

UPDATE  walmart_sales
SET Rating = 10.0 WHERE `DATE` ="2019-02-15 00:00:00";
ROLLBACK;

-- Modifying Date data type
ALTER TABLE walmart_sales
MODIFY `DATE` DATE
	
-- INSERTING INTO NEW TABLE FROM RAW DATA TYPES
INSERT  walmart_sales
SELECT * 
FROM walmart_rawdata;

--  ADDITION OF NEW COLUMNS 
SELECT `TIME` , 
(CASE
	WHEN `TIME` BETWEEN "00:00:00" AND "12:00:00" THEN "MORNING"
	WHEN `TIME` BETWEEN "12:01:00" AND "16:00:00" THEN "AFTERNOON"
    WHEN `TIME` BETWEEN "16:01:00" AND "23:59:59" THEN "EVENING"
END) AS Time_of_day
 FROM walmart_sales;
 
SELECT DAY(`DATE`) FROM walmart_sales; 
 
 
 
 --  CREATING NEW COLUMN Time_of_day to split time into various sections of the day
 ALTER TABLE walmart_sales ADD Time_of_day VARCHAR(15);
 
 
 --       INSERTING DATA USING CASE STATMENT
 UPDATE walmart_sales
 SET Time_of_day = (
CASE
	WHEN `TIME` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
	WHEN `TIME` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
    WHEN `TIME` BETWEEN "16:01:00" AND "23:59:59" THEN "Evening"
END);


-- INSERTING OF day_name column
ALTER TABLE walmart_sales ADD day_name VARCHAR(15);

UPDATE walmart_sales
SET day_name = DAYNAME(`DATE`);

-- INSERTING OF month_name
ALTER TABLE walmart_sales ADD month_name VARCHAR(15);

UPDATE walmart_sales
SET month_name = MONTHNAME(`DATE`);







-- LIST OF UNIQUE CITIES
SELECT DISTINCT City 
FROM walmart_sales;
### Query 2: Monthly Sales Trend

| City | 
|-------|
| Yangon    |
| Naypyitaw |
| Mandalay  | 


-- There are 3 distinct cities in the dataset
SELECT DISTINCT Branch, City
FROM walmart_sales;

| Branch | City      |
_______________________
A        | Yangon    |
B        | Mandalay  |
C        | Naypyitaw |
	
-- UNIQUE Product line
SELECT COUNT(DISTINCT(Product_line)) AS count_product_line
FROM walmart_sales;

| count_product_line | 
_______________________
6                      | 
--  --------------- The Most selling product line ----------
SELECT MAX(Payment_method)
FROM walmart_sales;

SELECT COUNT(payment_method) AS payment_count,Payment_method
FROM walmart_sales
GROUP BY Payment_method
ORDER BY Payment_count DESC;
# Ewallet is the most used payment method and was used 345 times

-- Food and beverages were the most product line sold and generated the most gross profit
SELECT Product_line,SUM(COGS) AS cogs
FROM walmart_sales
GROUP BY Product_line
ORDER BY cogs DESC;
 
 --  
 -- Food and beverages were the most goods sold

SELECT Product_line, SUM(Gross_income) AS Income
FROM walmart_sales
GROUP BY Product_line
ORDER BY Income;

-- Total Revenue per month
SELECT month_name,SUM(Total) AS Revenue
FROM walmart_sales
GROUP BY month_name
ORDER BY Revenue DESC;
-- Health and beauty genrated the most income 

-- COGS BY MONTH
SELECT month_name,SUM(COGS) AS cogs
FROM walmart_sales
GROUP BY month_name
ORDER BY cogs DESC;

--         MOST SELLING PRODUCT LINE ---
SELECT COUNT(Product_line) AS product_count,Product_line
FROM walmart_sales
GROUP BY Product_line
ORDER BY product_count DESC;

-- Product line with the highest revenue
SELECT Product_line,SUM(Total) AS Revenue
FROM walmart_sales
GROUP BY Product_line
ORDER BY Revenue DESC;

-- City with the highest revenue ( Naypyitaw has the highest revenue)
SELECT City,SUM(Total) AS Revenue
FROM walmart_sales
GROUP BY City
ORDER BY Revenue DESC;

-- Product with the highest VAT ( Food and beverages has the highest VAT)
SELECT Product_line,SUM(VAT) AS Total_VAT
FROM walmart_sales
GROUP BY Product_line
ORDER BY Total_VAT DESC;

-- Branch sales with respect to average product
SELECT Branch ,SUM(Quantity)
FROM walmart_sales
GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM walmart_sales);

-- Most common product line by gender
SELECT Gender,COUNT(Gender) AS cnt,Product_line 
FROM walmart_sales
GROUP BY Product_line,Gender
ORDER BY Gender,Product_line;

-- Average Rating of Each product line
SELECT ROUND(AVG(Rating),3) AS Avg_Rating, Product_line
FROM walmart_sales
GROUP BY Product_line
ORDER BY 1 ASC;
  


-- CUSTOMER QUERIES
-- Customer type that pays the most VAT
SELECT Customer_type,SUM(VAT) AS VAT_Sum
FROM walmart_sales
GROUP BY Customer_type
ORDER BY VAT_Sum DESC;
-- ANSWER: Member customer types pays the most VAT

-- Customer_type that generates the most revenue
SELECT Customer_type,SUM(Total) AS Revenue
FROM walmart_sales
GROUP BY Customer_type
ORDER BY Revenue DESC;
-- Customer type generates the highest revenue

-- Sales made at each time of the day
SELECT Time_of_day,SUM(Quantity) AS Sales
FROM walmart_sales
GROUP BY Time_of_day
ORDER BY Sales DESC;

-- Gender of the customer
SELECT COUNT(Gender) AS Gender_count,Gender,Customer_type
FROM walmart_sales
GROUP BY Gender,Customer_type
ORDER BY Gender;

-- Day of week having the best average rating 
SELECT AVG(Rating) AS Avg_rating,day_name
FROM walmart_sales
GROUP BY day_name
ORDER BY Avg_rating  DESC;

-- Time of the day customer give the best rating
SELECT AVG(Rating) AS Avg_Rating,Time_of_day
FROM walmart_sales
GROUP BY Time_of_day;

-- Gender dsitribution for each branch
SELECT COUNT(Gender) AS Gender_Count,Gender, Branch
FROM walmart_sales
GROUP BY Branch,Gender
ORDER BY Branch ;

-- Customer type that buys the most
SELECT Customer_type,SUM(Quantity) AS Purchase_power
FROM walmart_sales
GROUP BY Customer_type
ORDER BY Purchase_power DESC;

ALTER TABLE walmart_analysis.walmart_sales ADD Product_Type VARCHAR(20);
UPDATE walmart_sales
SET Product_Type = 
(CASE WHEN Unit_price < 25.5 THEN "Less Expensive"
WHEN Unit_price BETWEEN 25.5 AND 60 THEN "Expensive"
ELSE  "More Expensive"
END);


