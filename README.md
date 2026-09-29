# Retail Sales Data Cleaning & Analysis

## Project Overview

This project focuses on cleaning and analyzing retail sales data using MySQL.

The dataset was explored, cleaned, validated, and analyzed to identify sales patterns and generate useful business insights.

The project also demonstrates the use of advanced SQL concepts for business-oriented data analysis.

## Objective

The main objective of this project is to clean and analyze retail sales data using SQL and generate meaningful business insights.

The project aims to:

- Identify and handle data quality issues
- Validate sales and transaction data
- Analyze sales performance by category, payment method, and location
- Identify high-value customers and transactions
- Analyze monthly sales trends
- Apply advanced SQL techniques for deeper analysis

## Dataset

The project uses a retail store sales dataset containing transaction-level sales information.

The dataset includes:

- Transaction ID
- Customer ID
- Category
- Item
- Price Per Unit
- Quantity
- Total Spent
- Payment Method
- Location
- Transaction Date
- Discount Applied

## Tools & Technologies

- MySQL
- SQL
- MySQL Workbench
- GitHub

## Data Cleaning

The dataset was checked and cleaned using SQL.

The following data quality checks were performed:

- Checked for NULL values
- Checked for duplicate records
- Checked inconsistent categorical values
- Validated numerical values
- Verified `Total Spent` against `Price Per Unit × Quantity`
- Checked transaction dates
- Applied data-cleaning rules
- Rechecked the cleaned data

## Data Analysis

The cleaned data was analyzed to answer different business questions, including:

- What is the total sales amount?
- What is the average transaction value?
- What is the highest-value transaction?
- Which product categories generate the highest sales?
- Which payment methods generate the highest sales?
- Which locations generate the highest sales?
- Who are the top customers by spending?
- How do sales change month by month?
- Which days of the week generate higher sales?
- Which category has the highest total sales?

## Advanced SQL Concepts

The project also includes advanced SQL techniques such as:

- `CASE` statements
- Subqueries
- Common Table Expressions (CTEs)
- `RANK()`
- `ROW_NUMBER()`
- `PARTITION BY`
- `LAG()`
- `LEAD()`
- Date functions
- String functions
- Aggregate functions
- `ROUND()`
- SQL Views

## Project Structure

```text
Retail-Sales-Data-Analysis/
│
├── retail sales.sql
└── README.md
