SELECT 
	*
FROM ecommerce_customer_behavior_dataset;

-- SALES --
-- Total Sales
SELECT 
	ROUND(SUM(total_amount), 0) as total_sales
FROM ecommerce_customer_behavior_dataset;

-- Total Order
SELECT 
	count(order_id) as total_order
FROM ecommerce_customer_behavior_dataset;

-- Total Sales by Category
SELECT 
	product_category,
	ROUND(SUM(total_amount), 0) as total_sales
FROM ecommerce_customer_behavior_dataset
GROUP BY Product_Category
ORDER BY total_sales desc;

-- Category sale by Male gender
SELECT 
	product_category,
	count(gender) as 'Male Customers'
FROM ecommerce_customer_behavior_dataset
WHERE Gender = 'male'
GROUP BY Product_Category
ORDER BY Product_Category desc;

-- Category sale by Female gender
SELECT 
	product_category,
	count(gender) as 'Female Customers'
FROM ecommerce_customer_behavior_dataset
WHERE Gender = 'Female'
GROUP BY Product_Category
ORDER BY Product_Category desc;

-- Total Sales by city
SELECT 
	city,
	ROUND(SUM(total_amount), 0) as total_sales
FROM ecommerce_customer_behavior_dataset
GROUP BY City;

-- Total Sales by year
SELECT 
	DISTINCT datepart(YYYY, date) as Year,
	ROUND(SUM(total_amount), 0) as total_sales
FROM ecommerce_customer_behavior_dataset
GROUP BY datepart(YYYY, date);

-- Total Sales from each month in 2023
SELECT 
	datename(MONTH, date) as Month,
	ROUND(SUM(total_amount), 0) as 'Sales in 2023'
FROM ecommerce_customer_behavior_dataset 
WHERE datename(YYYY, date) = '2023'
GROUP BY datename(MM, date)
ORDER BY 
	CASE datename(MM, date)
		WHEN 'January' THEN 1
		WHEN 'February' THEN 2
		WHEN 'March' THEN 3
		WHEN 'April' THEN 4
		WHEN 'May' THEN 5
		WHEN 'June' THEN 6
		WHEN 'July' THEN 7
		WHEN 'August' THEN 8
		WHEN 'September' THEN 9
		WHEN 'October' THEN 10
		WHEN 'November' THEN 11
		WHEN 'December' THEN 12
	END;

-- Total Sales from each month in 2024
SELECT 
	datename(MM, date) as Month,
	ROUND(SUM(total_amount), 0) as 'Sales in 2024'
FROM ecommerce_customer_behavior_dataset 
WHERE datename(YYYY, date) = '2024'
GROUP BY datename(MM, date)
ORDER BY 
	CASE datename(MM, date)
		WHEN 'January' THEN 1
		WHEN 'February' THEN 2
		WHEN 'March' THEN 3
	END

-- Total Sales from each month in 2023 AND 2024
-- NOT YET SOLVED
SELECT 
	DISTINCT datepart(MM, date) as Month,
	(
		SELECT
			ROUND(SUM(total_amount), 0) 
		FROM ecommerce_customer_behavior_dataset 
		WHERE datepart(YYYY, date) = '2023'
	) as '2023',
	(
		SELECT 
			ROUND(SUM(total_amount), 0) 
		FROM ecommerce_customer_behavior_dataset 
		WHERE datepart(YYYY, date) = '2024'
	) as '2024'
FROM ecommerce_customer_behavior_dataset
GROUP BY datepart(MM, date)
ORDER BY month;

-- Total Units sold by category
SELECT 
	product_category,
	SUM(Quantity) as unit_sold
FROM ecommerce_customer_behavior_dataset
GROUP BY Product_Category;

-- CUSTOMER
-- Total Number of Custormer
SELECT 
	COUNT(Customer_ID)
FROM ecommerce_customer_behavior_dataset;

-- Number of Returning Customer
SELECT 
	COUNT(customer_id) as Existing_Customer
FROM ecommerce_customer_behavior_dataset
WHERE Is_Returning_Customer = 'true';

-- Number of New Customer
SELECT 
	COUNT(customer_id) as Existing_Customer
FROM ecommerce_customer_behavior_dataset
WHERE Is_Returning_Customer = 'false';

-- New Customer vs Returning Customer
SELECT 
	distinct Is_returning_customer,
	COUNT(customer_id) customers
FROM ecommerce_customer_behavior_dataset
GROUP BY Is_Returning_Customer;

-- Number of customer by Device Type
SELECT
	device_type,
	COUNT(customer_id) as Customers
FROM ecommerce_customer_behavior_dataset
GROUP BY device_type;

-- Number of Orders by Payment Type
SELECT
	Payment_Method,
	COUNT(Order_ID) as orders
FROM ecommerce_customer_behavior_dataset
GROUP BY Payment_Method;

-- Number of order with discount
SELECT
	COUNT(Order_ID) as orders_during_promo
FROM ecommerce_customer_behavior_dataset
WHERE Discount_Amount != 0;

-- Average Customer Rating
SELECT
	ROUND(AVG(Customer_Rating), 1) as Average_Customer_Rating
FROM ecommerce_customer_behavior_dataset;

-- Average Delivery Time
SELECT
	RIGHT('0' + CAST(AVG(Delivery_Time_Days) as varchar), 2) 
	as Average_delivery_time
FROM ecommerce_customer_behavior_dataset;

-- Average Delivery Time over each city
SELECT
	city,
	RIGHT('0' + CAST(AVG(Delivery_Time_Days) as varchar), 2) 
	as Average_delivery_time
FROM ecommerce_customer_behavior_dataset
GROUP BY city;

-- Another method
SELECT 
	CASE
		WHEN 
			AVG(Delivery_Time_Days) < 10 
		THEN '0' + CAST(AVG(Delivery_Time_Days) as varchar)
		ELSE CAST(AVG(Delivery_Time_Days) as varchar)
	END AS Average_delivery_time
FROM ecommerce_customer_behavior_dataset;

-- Average Discount Rate
SELECT
	ROUND(AVG(Discount_Amount), 0) as Average_Discount_Rate
FROM ecommerce_customer_behavior_dataset;

-- Discount Effectiveness by category
SELECT
	Product_Category,
	count(discount_amount) as Sales
FROM ecommerce_customer_behavior_dataset
WHERE discount_amount > 0
GROUP BY Product_Category;

-- Discount Effectiveness by city
SELECT
	City,
	ROUND(Sum(Total_Amount), 0) as Sales
FROM ecommerce_customer_behavior_dataset
WHERE discount_amount > 0
GROUP BY City;

-- Discount Effectiveness by Product Category
SELECT
	Product_Category,
	ROUND(Sum(Total_Amount), 0) as Sales
FROM ecommerce_customer_behavior_dataset
WHERE discount_amount > 0
GROUP BY Product_Category;

-- Units sold by category
SELECT
	Product_Category,
	SUM(quantity) as Unit_Sold
FROM ecommerce_customer_behavior_dataset
GROUP BY Product_Category

-- Late Delivery (%) over time
-- NOT YET SOLVED
SELECT 
	CASE
		WHEN
			delivery_time_days > 7
		THEN 1
		ELSE 0
	END as 'late_delivery'
FROM ecommerce_customer_behavior_dataset