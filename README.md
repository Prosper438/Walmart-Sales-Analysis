# Walmart-Sales-Analysis.

## Introduction and Project overview
This project analyzes the sales data of walmart and it is keen to give key insights and recommendations from insights from an interacive dashboard and SQL queries.

## Table of Contents.
- [Data Sources](#data-sources)
- [Data Cleaning and Modification](#data-cleaning-modification)
- [Exploratory Analysis](#Exploratory-Analysis)
- [Insights from data](#insight-from-data)
- [Conclusion](#Conclusion)
## Data Sources.
The data was extracted from the popular data bank KAGGLE. [WalmartSalesData.csv.csv](https://github.com/user-attachments/files/20378237/WalmartSalesData.csv.csv).
The raw data consists of 17 columns and 1000 rows.
Microsoft excel was used for dashboard creation and MySQL was used for data cleaning and modification.
The SQL queries used for data cleaning and modification can be gotten here.

## Data Cleaning and Modification.
In the aspect of data cleaning and modifications, nwe columns were added and also change of the data types of existing columns.
Below are the list of new columns added in the existing data with MySQL.
- Time_of_day = This divides the sales time into morning, afternoon and evening.
- Product_type = This classify the products based on cost.
- Month = Gives month date from the date column
- Day_name = Extracts the day name from the date column
Modifications were also made on the dataset by changing the column name  for the Total column to Revenue.
The data was loaded into MS Excel from MySQL with the aid of ODBC, which is then formatted as a table in microsoft excel.

## Exploratory Analysis.
From the analysis from the data,these questions was asked.
- How many distinct product line are there?
- What is the most selling product line
- What is the most used payment method
- Which product line generated the most gross profit
- What is the good that was sold the most
and alot more which answers will be available in the SQL section of this repository.

## Insights from data.
From the analysis of this data, the following insight can be gotten
- The most expensive products generates more than 55% of the total revenue, the most which is the Fashion accessories product line.
- Generally, by customer type, members generate more profits than the normal customer, only in some cases which narrows down to month and city that the opposite happens.
- From the dashboard, we could see that the profitable time of the day is evening.
- Concerning the payment method, E wallet was the most used payment method and Credit card was the least used.
- Evening generates more sales and revenue followed by afternoon and the least is morning

## Recommendations 
- From the dashboard, we could see that female are in front in terms of profit generation and fashion also genrates the most profit which aslo account a big percent <br> of more expensive products, so I believe that
  more resources should be focused on female fashion accessories.
- Food aand Beverages products should be pushed more into the market more, as it has potential to compete more with the fashion accessories line, due to the fact it < br > generates more Revenue for all product type than other goods
- From the data, we could see that credit cards was used more in the purchase of more expensive followed by the expensive, and males are the front runner in this, <br> so to generate more revenue, walmart can employed some credit
  card strategies like Buy now pay later or Free shipping for credit card payments over a certain amount.
- So I recommends increase working time on weekends, because from the= data we could see that Saturdays and sunday generate larger revenue than weekdays <br> ( Taking total revenue for saturday and sunday and divide by 2, and taking total revenue for weekdays divided by 5, then we could see weekends are a bit productive in revenue generation).
- Morning sales can be improved by using early morning promtions like 20% off before 11am e.t.c

## Conclusion.
From undegoing this project,we can see how little things affects business sales, and also how little decisions is crucial to business growth. Personally I valued the place of mySQL for <br> data cleaning and getting insights from data.
Access to the project Excel file can be accessed [here](https://github.com/Prosper438/Walmart-Sales-Analysis/blob/main/Excel%20sheet%20of%20project.md)


