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


ALTER TABLE walmart_analysis.walmart_sales ADD Product_Type VARCHAR(20);
UPDATE walmart_sales
SET Product_Type = 
(CASE WHEN Unit_price < 25.5 THEN "Less Expensive"
WHEN Unit_price BETWEEN 25.5 AND 60 THEN "Expensive"
ELSE  "More Expensive"
END);


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
6                    | 


-- Which payment method was used the most?
SELECT COUNT(payment_method) AS payment_count,Payment_method
FROM walmart_sales
GROUP BY Payment_method
ORDER BY Payment_count DESC;
-- Ewallet is the most used payment method and was used 345 times

| payment_count | Payment_method |     |
_________________________________
345       	| Ewallet        |
344	        | Cash           | 
	
311	        | Credit card    |

-- Which Proudct has the most COGS?
	
SELECT Product_line,SUM(COGS) AS cogs
FROM walmart_sales
GROUP BY Product_line
ORDER BY cogs DESC;
 
-- Food and beverages were the most product line sold and generated the most gross profit
| Product_line         | cogs     |
|______________________|__________|
Food and beverages     | 53471.28 |
Sports and travel      | 52497.93 |
Electronic accessories | 51750.03 |
Fashion accessories    | 51719.90 |
Home and lifestyle     | 51297.06 |
Health and beauty      | 46851.18 |
   

-- WHhich product line the most profit

SELECT Product_line, SUM(Gross_income) AS Income
FROM walmart_sales
GROUP BY Product_line
ORDER BY Income;

| Product line          | Income     |
|_______________________|____________|
Health and beauty	| 2342.5590 |
Home and lifestyle	| 2564.8530 |
Fashion accessories	| 2585.9950 |
Electronic accessories	| 2587.5015 |
Sports and travel	| 2624.8965 |
Food and beverages	| 2673.5640 |

-- Health and beauty genrated the most income 


	
-- Show Total Revenue per month
SELECT month_name,SUM(Revenue) AS Revenue
FROM walmart_sales
GROUP BY month_name
ORDER BY Revenue DESC;


| month_name | Income     |
|_________________________|
January	     | 116291.912 |
March	     | 109455.543 |
February     | 97219.411  |


-- COGS BY MONTH
	
SELECT month_name,SUM(COGS) AS cogs
FROM walmart_sales
GROUP BY month_name
ORDER BY cogs DESC;

| month_name | cogs      |
_________________________|
January	     | 110754.16 |
March	     | 104243.34 |
February     | 92589.88  |

	
--         MOST SELLING PRODUCT LINE ---
SELECT COUNT(Product_line) AS product_count,Product_line
FROM walmart_sales
GROUP BY Product_line
ORDER BY product_count DESC;

product_count |        Product_line     |
|_______________________________________|
178           | Fashion accessories     |
174           | Food and beverages      |
170           | Electronic accessories  |
166           | Sports and travel       |
160           | Home and lifestyle      |
152           | Health and beauty       |


-- Product line with the highest revenue
SELECT Product_line,SUM(Total) AS Revenue
FROM walmart_sales
GROUP BY Product_line
ORDER BY Revenue DESC;

| Product_line         | Revenue  |
|______________________|__________|
Food and beverages     | 56144.862|
Sports and travel      | 55122.846|
Electronic accessories | 54337.551|
Fashion accessories    | 54305.915|
Home and lifestyle     | 53861.929|
Health and beauty      | 49193.763|

	
-- City with the highest revenue ( Naypyitaw has the highest revenue)
	
SELECT City,SUM(Total) AS Revenue
FROM walmart_sales
GROUP BY City
ORDER BY Revenue DESC;

City       | Revenue   |
_______________________
Yangon	   |106200.409 |
Naypyitaw  |110568.748 |
Mandalay   |106197.709 |
	
-- Product with the highest VAT ( Food and beverages has the highest VAT)
SELECT Product_line,SUM(VAT) AS Total_VAT
FROM walmart_sales
GROUP BY Product_line
ORDER BY Total_VAT DESC;

  Product_line         | Total_vat |         
__________________________________
Food and beverages     | 2673.5640 |
Sports and travel      | 2624.8965 |
Electronic accessories | 2587.5015 |
Fashion accessories    | 2585.9950 |
Home and lifestyle     | 2564.8530 |
Health and beauty      | 2342.5590 |

	  
-- Branch sales with respect to average product
SELECT Branch ,SUM(Quantity) AS product_in_stock
FROM walmart_sales
GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM walmart_sales);

Branch | product_in_stock |
___________________________
A      | 1859
C      | 1831
B      | 1820
	
-- Most common product line by gender
SELECT Gender,COUNT(Gender) AS cnt,Product_line 
FROM walmart_sales
GROUP BY Product_line,Gender
ORDER BY Gender,Product_line;

Gender |  cnt |          Product_line 
______________________________________________
Female | 84   |	Electronic accessories
Female | 96   |	Fashion accessories
Female | 90   |	Food and beverages
Female | 64   |	Health and beauty
Female | 79   |	Home and lifestyle
Female | 88   |	Sports and travel
Male   | 86   |	Electronic accessories
Male   | 82   |	Fashion accessories
Male   | 84   |	Food and beverages
Male   | 88   |	Health and beauty
Male   | 81   |	Home and lifestyle
Male   | 78   |	Sports and travel

-- Average Rating of Each product line
SELECT ROUND(AVG(Rating),3) AS Avg_Rating, Product_line
FROM walmart_sales
GROUP BY Product_line
ORDER BY 1 ASC;


Avg_rating | Product_line   
_____________________________
6.838      | Home and lifestyle
6.916	   | Sports and travel
6.925	   | Electronic accessories
7.003	   | Health and beauty
7.029	   | Fashion accessories
7.113	   | Food and beverages




	
-- CUSTOMER QUERIES
-- Customer type that pays the most VAT
	
SELECT Customer_type,SUM(VAT) AS VAT_Sum
FROM walmart_sales
GROUP BY Customer_type
ORDER BY VAT_Sum DESC;

customer_type | VAT_Sum
_________________________
Member	      |7820.1640
Normal	      |7559.2050

	
-- ANSWER: Member customer types pays the most VAT

-- Customer_type that generates the most revenue
SELECT Customer_type,SUM(Total) AS Revenue
FROM walmart_sales
GROUP BY Customer_type
ORDER BY Revenue DESC;

Customer_type | Revenue
_______________________
Member	      | 164223.506
Normal	      | 158743.360
-- Customer type generates the highest revenue

-- Sales made at each time of the day
SELECT Time_of_day,SUM(Quantity) AS Sales
FROM walmart_sales
GROUP BY Time_of_day
ORDER BY Sales DESC;
_______________________
Time_of_day | Sales
_______________________
Morning	    | 1038
Evening	    | 2361
Afternoon   | 2111

-- Gender of the customer
SELECT COUNT(Gender) AS Gender_count,Gender,Customer_type
FROM walmart_sales
GROUP BY Gender,Customer_type
ORDER BY Gender;
________________________________________
Gender_count | Gender  | Customer_type
________________________________________
261	     | Female  | Member
240	     | Female  | Normal
240	     | Male    | Member
259	     | Male    | Normal

-- Day of week having the best average rating 
SELECT AVG(Rating) AS Avg_rating,day_name
FROM walmart_sales
GROUP BY day_name
ORDER BY Avg_rating  DESC;

Avg_rating|  day_name
____________________
7.15360   | Monday
7.07626	  | Friday
7.01128	  | Sunday
7.00316	  | Tuesday
6.90183   | Saturday
6.88986   | Thursday
6.80559	  | Wednesday

-- Time of the day customer give the best rating
SELECT AVG(Rating) AS Avg_Rating,Time_of_day
FROM walmart_sales
GROUP BY Time_of_day;

Avg_rating | Time_of_day
___________________________
6.92685	   | Evening
7.03130	   | Afternoon
6.96073	   | Morning

-- Gender dsitribution for each branch
SELECT COUNT(Gender) AS Gender_Count,Gender, Branch
FROM walmart_sales
GROUP BY Branch,Gender
ORDER BY Branch ;

________________________________________
Gender_count | Gender  | Branch
________________________________________
161	     | Female  | A
179          | Male    | A
162	     | Female  | B
170	     | Male    | B
178	     | Female  | C
150	     | Male    | C


-- Customer type that buys the most
SELECT Customer_type,SUM(Quantity) AS Purchase_power
FROM walmart_sales
GROUP BY Customer_type
ORDER BY Purchase_power DESC;

Customer_type | Purchase_power |
__________________________________
Member	      | 2785
Normal	      | 2725
