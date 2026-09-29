create database retail_sales_project;
USE retail_sales_project;
CREATE TABLE retail_sales_raw (
    transaction_id VARCHAR(30),
    customer_id VARCHAR(30),
    category VARCHAR(50),
    item VARCHAR(100),
    price_per_unit DECIMAL(10,2),
    quantity INT,
    total_spent DECIMAL(10,2),
    payment_method VARCHAR(50),
    location VARCHAR(50),
    transaction_date DATE,
    discount_applied VARCHAR(20)
);
SHOW TABLES;
select count(*) from retail_sales_raw;
select * from retail_sales_raw;
select count(distinct customer_id) from retail_sales_raw;
select distinct payment_method from retail_sales_raw;
select distinct location from retail_sales_raw;
select min(transaction_date) AS earliest_date,
max(transaction_date) AS latest_date;
select
    min(price_per_unit) AS minimum_price,
    max(price_per_unit) AS maximum_price,
    avg(price_per_unit) AS average_price,
    min(quantity) AS minimum_quantity,
    max(quantity) AS maximum_quantity,
    avg(quantity) AS average_quantity
from retail_sales_raw;
select count(*) from retail_sales_raw
where transaction_id is null;
select count(*) from retail_sales_raw
where customer_id is null;
select count(*) from retail_sales_raw
where category is null;
select count(*) from retail_sales_raw
where item is null;
select count(*) from retail_sales_raw
where price_per_unit is null;
select count(*) from retail_sales_raw
where quantity is null;
select count(*) from retail_sales_raw
where total_spent is null;
select count(*) from retail_sales_raw
where payment_method is null;
select count(*) from retail_sales_raw
where location is null;
select count(*) from retail_sales_raw
where transaction_date is null;
select count(*) from retail_sales_raw
where discount_applied is null;
select transaction_id, customer_id, category,item,
price_per_unit,quantity,total_spent,payment_method,
location,transaction_date,discount_applied,
count(*) from retail_sales_raw group by
transaction_id,customer_id,category,item,
price_per_unit,quantity,total_spent,payment_method,
location,transaction_date,discount_applied
having COUNT(*) > 1;
select category,count(*) 
from retail_sales_raw group by category order by category;
select payment_method,count(*) from retail_sales_raw
group by payment_method order by payment_method;
select location,count(*) from retail_sales_raw
group by location order by location;
select discount_applied,count(*) from retail_sales_raw
group by discount_applied order by discount_applied;
select
    min(price_per_unit),
    max(price_per_unit),
    avg(price_per_unit) from retail_sales_raw;
select
    min(quantity),
    max(quantity),
    avg(quantity) from retail_sales_raw;
select
    min(total_spent),
    max(total_spent),
    avg(total_spent) from retail_sales_raw;
select
    sum(price_per_unit <= 0),
    sum(quantity <= 0) ,
    sum(total_spent <= 0) from retail_sales_raw;
create table retail_sales_cleaned as
select * from retail_sales_raw;
SHOW TABLES;
select count(*) from retail_sales_cleaned;
set sql_safe_updates = 0;
update retail_sales_cleaned set
    transaction_id = trim(transaction_id),
    customer_id = trim(customer_id),
    category = trim(category),
    item = trim(item),
    payment_method = trim(payment_method),
    location = trim(location),
    discount_applied = trim(discount_applied);
set sql_safe_updates = 1;
select count(*) from retail_sales_cleaned;
select
    sum(transaction_id is null),
    sum(customer_id is null),
    sum(category is null),
    sum(item is null),
    sum(price_per_unit is null),
    sum(quantity is null),
    sum(total_spent is null) ,
    sum(payment_method is null) ,
    sum(location is null) ,
    sum(transaction_date is null),
    sum(discount_applied is null) 
from retail_sales_cleaned;
select transaction_id,count(*) 
from retail_sales_cleaned group by transaction_id having COUNT(*) > 1;
select count(*) from retail_sales_cleaned where ABS((price_per_unit * quantity) - total_spent
) > 0.01;
select sum(total_spent) from retail_sales_cleaned;
select avg(total_spent) from retail_sales_cleaned;
select max(total_spent) from retail_sales_cleaned;
select category,count(*),sum(total_spent),
avg(total_spent) from retail_sales_cleaned
group by category order by 3 desc;
select payment_method,count(*),sum(total_spent),avg(total_spent) 
from retail_sales_cleaned group by payment_method order by 3 desc;
select payment_method,count(*),sum(total_spent),avg(total_spent) 
from retail_sales_cleaned group by payment_method order by 3 desc;
SELECT
    payment_method,
    COUNT(*),
    SUM(total_spent),
    AVG(total_spent)
FROM retail_sales_cleaned
GROUP BY payment_method
ORDER BY 3 DESC;
SELECT
    location,
    COUNT(*),
    SUM(total_spent),
    AVG(total_spent)
FROM retail_sales_cleaned
GROUP BY location
ORDER BY 3 DESC;
SELECT
    customer_id,
    COUNT(*) ,
    SUM(total_spent) ,
    AVG(total_spent) 
FROM retail_sales_cleaned
GROUP BY customer_id
ORDER BY 3 DESC
LIMIT 10;
SELECT
    YEAR(transaction_date) AS sales_year,
    MONTH(transaction_date) AS sales_month,
    SUM(total_spent),
    COUNT(*) 
FROM retail_sales_cleaned
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY sales_year, sales_month;
SELECT
    transaction_id,
    total_spent,
    CASE
        WHEN total_spent >= 100 THEN 'High Value'
        WHEN total_spent >= 50 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS transaction_category
FROM retail_sales_cleaned;
SELECT
    transaction_id,
    customer_id,
    total_spent
FROM retail_sales_cleaned
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM retail_sales_cleaned
)
ORDER BY total_spent DESC;
SELECT
    transaction_id,
    customer_id,
    total_spent
FROM retail_sales_cleaned
WHERE total_spent = (
    SELECT MAX(total_spent)
    FROM retail_sales_cleaned
);
SELECT
    customer_id,
    SUM(total_spent) AS total_customer_spent
FROM retail_sales_cleaned
GROUP BY customer_id
HAVING SUM(total_spent) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(total_spent) AS customer_total
        FROM retail_sales_cleaned
        GROUP BY customer_id
    ) AS customer_sales
)
ORDER BY total_customer_spent DESC;
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(total_spent) AS total_spent
    FROM retail_sales_cleaned
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spent
FROM customer_sales
WHERE total_spent > 500
ORDER BY total_spent DESC;
SELECT
    customer_id,
    SUM(total_spent) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(total_spent) DESC
    ) AS customer_rank
FROM retail_sales_cleaned
GROUP BY customer_id
ORDER BY customer_rank;
SELECT
    customer_id,
    SUM(total_spent) AS total_spent,
    ROW_NUMBER() OVER (
        ORDER BY SUM(total_spent) DESC
    ) AS row_num
FROM retail_sales_cleaned
GROUP BY customer_id
ORDER BY row_num;
SELECT
    category,
    transaction_id,
    total_spent,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_spent DESC
    ) AS category_rank
FROM retail_sales_cleaned
ORDER BY category, category_rank;
WITH monthly_sales AS (
    SELECT
        YEAR(transaction_date) AS sales_year,
        MONTH(transaction_date) AS sales_month,
        SUM(total_spent) AS total_sales
    FROM retail_sales_cleaned
    GROUP BY YEAR(transaction_date), MONTH(transaction_date)
)
SELECT
    sales_year,
    sales_month,
    total_sales,
    LAG(total_sales) OVER (
        ORDER BY sales_year, sales_month
    ) AS previous_month_sales
FROM monthly_sales
ORDER BY sales_year, sales_month;
WITH monthly_sales AS (
    SELECT
        YEAR(transaction_date) AS sales_year,
        MONTH(transaction_date) AS sales_month,
        SUM(total_spent) AS total_sales
    FROM retail_sales_cleaned
    GROUP BY YEAR(transaction_date), MONTH(transaction_date)
)
SELECT
    sales_year,
    sales_month,
    total_sales,
    LEAD(total_sales) OVER (
        ORDER BY sales_year, sales_month
    ) AS next_month_sales
FROM monthly_sales
ORDER BY sales_year, sales_month;
WITH monthly_sales AS (
    SELECT
        YEAR(transaction_date) AS sales_year,
        MONTH(transaction_date) AS sales_month,
        SUM(total_spent) AS total_sales
    FROM retail_sales_cleaned
    GROUP BY YEAR(transaction_date), MONTH(transaction_date)
),
sales_comparison AS (
    SELECT
        sales_year,
        sales_month,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY sales_year, sales_month
        ) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    sales_year,
    sales_month,
    total_sales,
    previous_month_sales,
    ROUND(
        ((total_sales - previous_month_sales) / previous_month_sales) * 100,
        2
    ) AS growth_percentage
FROM sales_comparison
ORDER BY sales_year, sales_month;
SELECT
    transaction_id,
    transaction_date,
    DAYNAME(transaction_date) AS day_name
FROM retail_sales_cleaned;
SELECT
    DAYNAME(transaction_date) AS day_name,
    COUNT(*) AS total_transactions,
    SUM(total_spent) AS total_sales
FROM retail_sales_cleaned
GROUP BY DAYNAME(transaction_date)
ORDER BY total_sales DESC;
SELECT
    category,
    UPPER(category) AS category_upper,
    LOWER(category) AS category_lower
FROM retail_sales_cleaned;
SELECT
    category,
    TRIM(category) AS cleaned_category
FROM retail_sales_cleaned;
SELECT
    customer_id,
    category,
    CONCAT(customer_id, ' - ', category) AS customer_category
FROM retail_sales_cleaned;
SELECT
    item,
    SUBSTRING(item, 1, 8) AS item_part
FROM retail_sales_cleaned;
SELECT
    customer_id,
    AVG(total_spent) AS average_spent,
    ROUND(AVG(total_spent), 2) AS rounded_average_spent
FROM retail_sales_cleaned
GROUP BY customer_id
ORDER BY rounded_average_spent DESC;
SELECT
    category,
    SUM(total_spent) AS total_sales
FROM retail_sales_cleaned
GROUP BY category
ORDER BY total_sales DESC
LIMIT 1;
CREATE VIEW retail_sales_summary AS
SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(total_spent) AS total_sales,
    ROUND(AVG(total_spent), 2) AS average_transaction_value,
    MAX(total_spent) AS highest_transaction
FROM retail_sales_cleaned;
