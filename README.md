# Walmart-Sales-Analysis.

## Introduction and Project overview
This project analyzes the sales data of walmart and it is keen to give key insights and recommendations from insights from an interacive dashboard and SQL queries.

## Table of Contents.


## Data Sources.
The data was extracted from the popular data bank KAGGLE. [WalmartSalesData.csv.csv](https://github.com/user-attachments/files/20378237/WalmartSalesData.csv.csv).
The raw data consists of 17 columns and 1000 rows.
Microsoft excel was used for dashboard creation and MySQL was used for data cleaning and modification.
The SQL queries used for data cleaning and modification can be gotten here.

## Data  Cleaning and Modification.
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


## Recommendations 
- From the dashboard, we could see that female are in front in terms of profit generation and fashion also genrates the most profit which aslo account a big percent <br> of more expensive products, so I believe that
  more resources should be focused on female fashion accessories.
- Food aand Beverages products should be pushed more into the market more, as it has potential to compete more with the fashion accessories line, due to the fact it < br > generates more Revenue for all product type than other goods 

