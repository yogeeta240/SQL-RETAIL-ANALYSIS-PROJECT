-- SQL RETAIL SALES ANALYSIS PROJECT--

-- WE HAVE ALREADY CREATED TABLE NAMED retail_sales--
SELECT  TOP 100 * FROM retail_sales
ORDER BY Transaction_Id ASC ; -- Command to select the top 100 rows 

EXEC sp_help retail_sales; -- Command to check the structure of the table 

SELECT COUNT(*) AS total_rows -- Command to check the total no.of rows in the table.
FROM retail_sales;


SELECT *
FROM retail_sales                  -- COMMAND TO CHECK FOR NULL VALUES IN THE COLUMN--
WHERE Transaction_Id IS NULL;

SELECT Transaction_Id, COUNT(*)
FROM retail_sales                  -- COMMAND TO CHECK FOR THE DUPLICATE VALUES IN THE COLUMN--
GROUP BY Transaction_Id
HAVING COUNT(*) > 1;

ALTER TABLE retail_sales
ALTER COLUMN Transaction_Id FLOAT NOT NULL;
ALTER TABLE retail_sales
ADD CONSTRAINT PK_retail_sales      -- COMMAND TO MAKE THE TRANSACTION_ID COLUMN AS PRIMARY KEY---
PRIMARY KEY (Transaction_Id);

-- DATA CLEANING---
SELECT *
FROM retail_sales
WHERE
	Transaction_Id IS NULL
	OR Customer_ID IS NULL
	OR Gender IS NULL               -- COMMAND TO CHECK THE NULL VALUES IN THE TABLE--
	OR Age IS NULL
	OR Product_Category IS NULL
	OR Quantity IS NULL
	OR Price_per_Unit IS NULL;

	-- DATA EXPLORATION---
	-- HOW MANY SALES DO WE HAVE ?--
	SELECT COUNT(*) AS total_sales
	FROM retail_sales;
	-- HOW MANY CUSTOMERS  DO WE HAVE?--

SELECT Customer_ID, COUNT(*)
FROM retail_sales                  -- COMMAND TO CHECK FOR THE DUPLICATE VALUES IN THE COLUMN--
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

	SELECT COUNT(DISTINCT Customer_ID) AS total_customers
	FROM retail_sales;              -- COMMAND TO COUNT THE UNIQUE CUSTOMERS IN THE TABLE BY USING DISTINCT---

	SELECT COUNT(DISTINCT Product_Category) AS total_category
	FROM retail_sales;   -- COMMAND TO CHECK THE TOTAL NUMBER OF CATEGORY IN THE TABLE--

	SELECT DISTINCT Product_Category FROM retail_sales;

	-- DATA ANALYSIS AND BUSINESS PROBLEMS AND ANSWERS--
	--1.Write a SQL query to retrieve all columns for category 'clothing':
	SELECT * FROM retail_sales WHERE Product_Category='Clothing';

	--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 :4
	SELECT * FROM retail_sales WHERE Product_Category='Clothing' AND Quantity>=4;

	--3.Write a SQL query to calculate the total sales (total_sale) for each category.:
	SELECT Product_Category,COUNT(*) AS total_sales FROM retail_sales GROUP BY Product_Category;

	--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
	SELECT Product_Category , AVG(Age) FROM retail_sales WHERE Product_Category='Beauty' GROUP BY Product_Category;

	--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
	SELECT Transaction_ID FROM retail_sales WHERE Total_Amount>1000;

	--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
	--SELECT  Gender,Product_Category,Count(*) AS total_transactions FROM retail_sales GROUP BY Gender,Product_Category ORDER BY 1;
	SELECT 
		Gender,
		COUNT(*) AS total_transactions,
		SUM(CASE WHEN Product_Category = 'Beauty' THEN 1 ELSE 0 END) AS Beauty,
		SUM(CASE WHEN Product_Category = 'Clothing' THEN 1 ELSE 0 END) AS Clothing,
		SUM(CASE WHEN Product_Category = 'Electronics' THEN 1 ELSE 0 END) AS Electronics
		FROM retail_sales
		GROUP BY Gender;

--7.**Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT TOP 5 Customer_ID ,SUM(Total_Amount) AS TOTAL_SALES FROM retail_sales GROUP BY Customer_ID,Total_Amount ORDER BY Total_Amount DESC;

--8.Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT  Product_Category, COUNT(DISTINCT Customer_ID) AS unique_customers FROM retail_sales GROUP BY Product_Category;
