/*

-----------------------------------------------------------------------------------------------------------------------------------
                                               Guidelines
-----------------------------------------------------------------------------------------------------------------------------------

The provided document is a guide for the project. Follow the instructions and take the necessary steps to finish
the project in the SQL file			
-----------------------------------------------------------------------------------------------------------------------------------

											Database Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------
*/

-- [1] To begin with the project, you need to create the database first
-- Write the Query below to create a Database

-- First let's drop any datase called vehdb if by any chance it exists
DROP DATABASE IF EXISTS vehdb;

-- Let's crate a database called vehdb
CREATE DATABASE vehdb;

-- [2] Now, after creating the database, you need to tell MYSQL which database is to be used.
-- Write the Query below to call your Database

USE vehdb;

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Tables Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [3] Creating the tables:

/*Note:
---> To create the table, refer to the ER diagram and the solution architecture. 
---> Refer to the column names along with the data type while creating a table from the ER diagram.
---> If needed revisit the videos Week 2: Data Modeling and Architecture: Creating DDLs for Your Main Dataset and Normalized Datasets
---> While creating a table, make sure the column you assign as a primary key should uniquely identify each row.
---> If needed revisit the codes used to create tables for the gl_eats database. 
     This will help in getting a better understanding of table creation.*/


/* List of tables to be created.

 Create a table temp_t, vehicles_t, order_t, customer_t, product_t, shipper_t */

-- Create a table temp_t. This is a temporary table that will load each quarterly new data.

-- To drop the table if already exists
DROP TABLE IF EXISTS temp_t;            

-- Create a table temp_t

CREATE TABLE temp_t
(
	shipper_id INTEGER,
	shipper_name VARCHAR(50),
	shipper_contact_details VARCHAR(30),
	product_id INTEGER,
	vehicle_maker VARCHAR(60),
	vehicle_model VARCHAR(60),
	vehicle_color VARCHAR(60),
	vehicle_model_year INTEGER,
	vehicle_price DECIMAL(14,2),
	quantity INTEGER,
	discount DECIMAL(4,2),
	customer_id VARCHAR(25),
	customer_name VARCHAR(25),
	gender VARCHAR(15),
	job_title VARCHAR(50),
	phone_number VARCHAR(20),
	email_address VARCHAR(50),
	city VARCHAR(25),
	country VARCHAR(40),
	state VARCHAR(40),
	customer_address VARCHAR(50),
	order_date DATE,
	order_id VARCHAR(25),
	ship_date DATE,
	ship_mode VARCHAR(25),
	shipping VARCHAR(30),
	postal_code INTEGER,
	credit_card_type VARCHAR(40),
	credit_card_number BIGINT,
	customer_feedback VARCHAR(20),
	quarter_number INTEGER,
	PRIMARY KEY (order_id, shipper_id, product_id, customer_id)                    
);  

-- Create a table vehicles_t. This table will accumulate all the quarterly data.

DROP TABLE IF EXISTS vehicles_t; 

CREATE TABLE vehicles_t
(
	shipper_id INTEGER,
	shipper_name VARCHAR(50),
	shipper_contact_details VARCHAR(30),
	product_id INTEGER,
	vehicle_maker VARCHAR(60),
	vehicle_model VARCHAR(60),
	vehicle_color VARCHAR(60),
	vehicle_model_year INTEGER,
	vehicle_price DECIMAL(14,2),
	quantity INTEGER,
	discount DECIMAL(4,2),
	customer_id VARCHAR(25),
	customer_name VARCHAR(25),
	gender VARCHAR(15),
	job_title VARCHAR(50),
	phone_number VARCHAR(20),
	email_address VARCHAR(50),
	city VARCHAR(25),
	country VARCHAR(40),
	state VARCHAR(40),
	customer_address VARCHAR(50),
	order_date DATE,
	order_id VARCHAR(25),
	ship_date DATE,
	ship_mode VARCHAR(25),
	shipping VARCHAR(30),
	postal_code INTEGER,
	credit_card_type VARCHAR(40),
	credit_card_number BIGINT,
	customer_feedback VARCHAR(20),
	quarter_number INTEGER,
	PRIMARY KEY (order_id, shipper_id, product_id, customer_id)                    
);  

-- Create table order_t. This tabel will have information related to the vehicle ordered.

DROP TABLE IF EXISTS order_t;

CREATE TABLE order_t
(
	order_id VARCHAR(25),
    customer_id VARCHAR(25),
    shipper_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
	vehicle_price DECIMAL(14,2),
    order_date DATE,
	ship_date DATE,
    discount DECIMAL(4,2),
	ship_mode VARCHAR(25),
	shipping VARCHAR(30),
    customer_feedback VARCHAR(20),
	quarter_number INTEGER,
	PRIMARY KEY (order_id)                    
);  

-- Create table customer_t. This tabel will have information related to the customers.

DROP TABLE IF EXISTS customer_t;

CREATE TABLE customer_t
(
	customer_id VARCHAR(25),
	customer_name VARCHAR(25),
	gender VARCHAR(15),
	job_title VARCHAR(50),
	phone_number VARCHAR(20),
	email_address VARCHAR(50),
	city VARCHAR(25),
	country VARCHAR(40),
	state VARCHAR(40),
	customer_address VARCHAR(50),
    postal_code INTEGER,
	credit_card_type VARCHAR(40),
	credit_card_number BIGINT,
	PRIMARY KEY (customer_id)                    
);  
	

-- Create table shipper_t. This tabel will have information related to the shipper.

DROP TABLE IF EXISTS shipper_t;

CREATE TABLE shipper_t
(
	shipper_id INTEGER,
	shipper_name VARCHAR(50),
	shipper_contact_details VARCHAR(30),
	PRIMARY KEY (shipper_id)                    
);  


-- Create table product_t. This tabel will have information related to the product.

DROP TABLE IF EXISTS product_t;

CREATE TABLE product_t
(
	product_id INTEGER,
	vehicle_maker VARCHAR(60),
	vehicle_model VARCHAR(60),
	vehicle_color VARCHAR(60),
	vehicle_model_year INTEGER,
	vehicle_price DECIMAL(14,2),
	PRIMARY KEY (product_id)                    
);  

                                                  
/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:

/*Note:

---> If needed revisit the video: Week 2: Data Modeling and Architecture: Introduction to Stored Procedures.
---> Also revisit the codes used to create stored procedures for the gl_eats database. 
	 This will help in getting a better understanding of the creation of stored procedures.*/


/* List of stored procedures to be created.

   Creating the stored procedure for vehicles_p, order_p, customer_p, product_p, shipper_p*/
   
/* Create a procedure vehicles_p. This procedure will store all the data into the main table vehicles_t. 
It will have all the columns and will accumulate all the data that is generated every quarter. */


-- To drop the stored procedure if already exists- 
DROP PROCEDURE IF EXISTS vehicles_p;

-- Syntax to create a stored procedure-
DELIMITER $$ 
CREATE PROCEDURE vehicles_p()
BEGIN
	INSERT INTO vehicles_t 
	(
		shipper_id,
		shipper_name,
		shipper_contact_details,
		product_id,
		vehicle_maker,
		vehicle_model,
		vehicle_color,
		vehicle_model_year,
		vehicle_price,
		quantity,
		discount,
		customer_id,
		customer_name,
		gender,
		job_title,
		phone_number,
		email_address,
		city,
		country,
		state,
		customer_address,
		order_date,
		order_id,
		ship_date,
		ship_mode,
		shipping,
		postal_code,
		credit_card_type,
		credit_card_number,
		customer_feedback,
		quarter_number
	) 
	SELECT * FROM temp_t;
END;


/* Create procedure order_p. This procedure  will store the data related to the orders made each quarter.
This table is populated every quarter, when new orders are made (the where conditional). For this reason we need to specify in the call of the procedure 
which quarter we are updating the table.*/ 

DROP PROCEDURE IF EXISTS order_p;

DELIMITER $$
CREATE PROCEDURE order_p(quarter_num INTEGER)
BEGIN
	INSERT INTO order_t
    (
		order_id,
		customer_id,
		shipper_id,
		product_id,
		quantity,
		vehicle_price,
		order_date,
		ship_date,
		discount,
		ship_mode,
		shipping,
		customer_feedback,
		quarter_number
	)
    SELECT DISTINCT
		order_id,
		customer_id,
		shipper_id,
		product_id,
		quantity,
		vehicle_price,
		order_date,
		ship_date,
		discount,
		ship_mode,
		shipping,
		customer_feedback,
		quarter_number
	FROM vehicles_t
    WHERE quarter_number = quarter_num;
END;
    
    
/* Create procedure customer_p. This procedure will store the data about the customers (name, gender, address, etc).
Customer table is a dimension table and will have the unique information about the customer.  
We only populate the tabe if a new customer appears in the data generated in that quarter (the where condicional) */

DROP PROCEDURE IF EXISTS customer_p;

DELIMITER $$
CREATE PROCEDURE customer_p()
BEGIN
	INSERT INTO customer_t
    (
		customer_id,
		customer_name,
		gender,
		job_title,
		phone_number,
		email_address,
		city,
		country,
		state,
		customer_address,
		postal_code,
		credit_card_type,
		credit_card_number
	)
    SELECT DISTINCT
		customer_id,
		customer_name,
		gender,
		job_title,
		phone_number,
		email_address,
		city,
		country,
		state,
		customer_address,
		postal_code,
		credit_card_type,
		credit_card_number
    FROM vehicles_t
    WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM customer_t);
END;

/* Create procedure shipper_p. This procedure will store the data about the shipper (name,contact).
Shipper table is a dimension table and will have the unique information about the shipper.  
We only populate the tabe if a new shipper appears in the data generated in that quarter (the where condicional) */

DROP PROCEDURE IF EXISTS shipper_p;

DELIMITER $$
CREATE PROCEDURE shipper_p()
BEGIN
	INSERT INTO shipper_t
    (
		shipper_id,
		shipper_name,
		shipper_contact_details
	)
    SELECT DISTINCT
    	shipper_id,
		shipper_name,
		shipper_contact_details
	FROM vehicles_t 
    WHERE shipper_id NOT IN (SELECT DISTINCT shipper_id FROM shipper_t);
END;


/* Create procedure product_p. This procedure will store the data about the product (car maker, model, color, etc).
Product table is a dimension table and will have the unique information about the product.  
We only populate the table if a new product appears in the data generated in that quarter (the where condicional) */

DROP IF EXISTS PROCEDURE product_p;

DELIMITER $$
CREATE PROCEDURE product_p()
BEGIN
	INSERT INTO product_t
    (
		product_id,
		vehicle_maker,
		vehicle_model,
		vehicle_color,
		vehicle_model_year,
		vehicle_price
	)
    SELECT DISTINCT 
		product_id,
		vehicle_maker,
		vehicle_model,
		vehicle_color,
		vehicle_model_year,
		vehicle_price
	FROM vehicles_t
    WHERE product_id NOT IN (SELECT DISTINCT product_id FROM product_t);
END;

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Data Ingestion
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [5] Ingesting the data:
-- Note: Revisit the video: Week-2: Data Modeling and Architecture: Ingesting data into the main table

TRUNCATE temp_t;

LOAD DATA LOCAL INFILE "C:/Users/danie/Documents/4 - SQL Course/7 - Final project New Wheels/Data/new_wheels_sales_qtr_4.csv" -- change this location to load another week
INTO TABLE temp_t
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

call vehicles_p();
call customer_p();
call product_p();
call shipper_p();
call order_p(4);

/* Note: 

---> With the help of the above code, you can ingest the data into temp_t table by ingesting the quarterly data and by calling the stored 
     procedures you can ingest the data into separate table.
---> You have to run the above ingestion code 4 times as 4 quarters of data are present and you also need to call all the stored procedures 
     4 times. Please change the argument value while calling the stored procedure order_p(n). (n = 1,2,3,4)
---> If needed revisit the videos: Week 2: Data Modeling and Architecture: Ingesting data into the main table and Ingesting future weeks of data
---> Also revisit the codes used to ingest the data for the gl_eats database. 
     This will help in getting a better understanding of how to ingest the data into various respective tables.*/


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Views Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [6] Creating the views:

/*Note: 

---> If needed revisit the videos: Week-2: Data Modeling and Architecture: Creating views for answers to business questions
---> Also revisit the codes used to create views for the gl_eats database. 
	 This will help in getting a better understanding of the creation of views.*/



-- List of views to be created are "veh_prod_cust_v" , "veh_ord_cust_v"

-- Let's create a view veh_prod_cust_v joining the tables customer_t, order_t and product_t.

-- To drop the views if already exists- 
DROP VIEW IF EXISTS veh_prod_cust_v;

-- To create a view-
CREATE VIEW veh_prod_cust_v AS
    SELECT
		c.customer_id,
		c.customer_name,
		c.credit_card_type,
		c.state,
		o.order_id,
		o.customer_feedback,
        p.product_id,
		p.vehicle_maker,
		p.vehicle_model,
		p.vehicle_color,
		p.vehicle_model_year
	FROM customer_t AS c
		INNER JOIN order_t AS o
			ON c.customer_id = o.customer_id
		INNER JOIN product_t AS p
			ON p.product_id = o.product_id;

-- Let's create a view veh_ord_cust_v joining the tables customer_t and order_t.

DROP VIEW IF EXISTS veh_ord_cust_v;

CREATE VIEW veh_ord_cust_v AS
	SELECT
		c.customer_id,
		c.customer_name,
		c.city,
        c.state,
        c.credit_card_type,
		o.order_id,
        o.shipper_id,
		o.product_id,
		o.quantity,
        o.vehicle_price,
		o.order_date,
		o.ship_date,
        o.discount,
		o.customer_feedback,
		o.quarter_number
    FROM order_t AS o
    INNER JOIN customer_t AS c
    ON o.customer_id = c.customer_id;

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Functions Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [7] Creating the functions:

/*Note: 

---> If needed revisit the videos: Week-2: Data Modeling and Architecture: Creating User Defined Functions
---> Also revisit the codes used to create functions for the gl_eats database. 
     This will help in getting a better understanding of the creation of functions.*/

-- Let's create the function calc_revenue_f to calculate the revenue considering the price of the car, the discount and the quantity ordered.

DROP FUNCTION IF EXISTS calc_revenue_f;

DELIMITER $$
CREATE FUNCTION calc_revenue_f (vehicle_price DECIMAL(14,2), discount DECIMAL(4,2), quantity INT)
RETURNS DECIMAL(14,2)
DETERMINISTIC
BEGIN
	RETURN ((vehicle_price - (vehicle_price * discount)) * quantity);
END;


-- Let's create the function days_to_ship_f to calculate the difference between the ship date and the order date.

DROP FUNCTION IF EXISTS days_to_ship_f;

DELIMITER $$
CREATE FUNCTION days_to_ship_f (ship_date DATE, order_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN 
	RETURN DATEDIFF(ship_date, order_date);
END;


/*-----------------------------------------------------------------------------------------------------------------------------------
Note: 
After creating tables, stored procedures, views and functions, attempt the below questions.
Once you have got the answer to the below questions, download the csv file for each question and use it in Python for visualisations.
------------------------------------------------------------------------------------------------------------------------------------ 

  
  
-----------------------------------------------------------------------------------------------------------------------------------

                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  -- Viewing all the tables and views to understand the data and help with the questions to be answered.
  
  SELECT * FROM customer_t;
  SELECT * FROM order_t;
  SELECT * FROM product_t;
  SELECT * FROM shipper_t;
  SELECT * FROM veh_ord_cust_v;
  SELECT * FROM veh_prod_cust_v;

-- ---------------------------------------------------------------------------------------------------------------------------------
  
  -- BUSINESS OVERVIEW
  -- Answering questions about the business overview
  
  -- TOTAL REVENUE
  SELECT
	SUM(calc_revenue_f(vehicle_price, discount, quantity)) AS total_revenue
  FROM order_t;
  
  -- The total revenue is 48.6 millions.
  
  -- TOTAL ORDERS
  SELECT
	COUNT(order_id) AS total_orders
  FROM order_t;
  
  -- The total number of orders is 1000.
  
  -- TOTAL CUSTOMERS
  SELECT
	COUNT(customer_id) AS total_customers
  FROM customer_t;
  
  -- There are 994 customrers.
  
  -- AVERAGE RATING
  WITH Customer_feedb AS 
(
	SELECT
		CASE
			WHEN customer_feedback = 'Very Bad' THEN 1
			WHEN customer_feedback = 'Bad' THEN 2
			WHEN customer_feedback = 'Okay' THEN 3
			WHEN customer_feedback = 'Good' THEN 4 
			WHEN customer_feedback = 'Very Good' THEN 5
		END AS customer_rating
	FROM order_t
)
SELECT
	AVG(customer_rating) AS Avg_customer_rating
FROM Customer_feedb;

-- The average customer rating is 3.13.

-- AVERAGE DAYS TO SHIP
SELECT
	AVG(days_to_ship_f(ship_date, order_date)) AS Avg_days_to_ship
FROM order_t;

-- The average days to ship the car is 98 days.

-- PERCENTAGE OF FEEDBACK BY CATEGORY

SELECT
	customer_feedback,
	COUNT(customer_feedback) AS number_feedbacks,
	(SELECT COUNT(order_id) FROM order_t) AS total_feedbacks,
	COUNT(customer_feedback) / (SELECT COUNT(order_id) FROM order_t) * 100  AS percentage_customer_feedback
FROM order_t
GROUP BY 1
ORDER BY 2;
    
/* Bad and Very Bad feedbacks are around 18 % each. Okay, Good and Very Good feedbacks are around 20% each.
There are a high percentage of Bad and Very Bed feedbacks, around 36% combined. It's almost the same percentage as Good and 
Very Good feedbacks, around 43% combined.*/

-- --------------------------------------------------------------------------------------------------------------------------------
  
  
/*-- QUESTIONS RELATED TO CUSTOMERS
     [Q1] What is the distribution of customers across states?
     Hint: For each state, count the number of customers.*/

SELECT
	state,
	COUNT(customer_id) AS number_of_customers
FROM customer_t
GROUP BY 1
ORDER BY 2 DESC;

/* California and Texas are the states with the biggest number of customers, folllowed by Florida and New York.
Maine, Wyoming and Vermont are the states with the least number of customers. */

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q2] What is the average rating in each quarter?
-- Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.

Hint: Use a common table expression and in that CTE, assign numbers to the different customer ratings. 
      Now average the feedback for each quarter. 

Note: For reference, refer to question number 10. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions from this question.*/

WITH Customer_fb AS 
(
	SELECT
		quarter_number,
		CASE
			WHEN customer_feedback = 'Very Bad' THEN 1
			WHEN customer_feedback = 'Bad' THEN 2
			WHEN customer_feedback = 'Okay' THEN 3
			WHEN customer_feedback = 'Good' THEN 4 
			WHEN customer_feedback = 'Very Good' THEN 5
		END AS customer_rating
	FROM order_t
)
SELECT
	quarter_number,
	AVG(customer_rating) AS Avg_customer_rating
FROM Customer_FB
GROUP BY 1
ORDER BY 2 DESC;

/* The first quarter has the higher customer rating, folowed by the second quarter, third quarter and fourth quarter.
The ratings are getting worse with each quarter, the customers are not satisfied with the company services. 
The company needs to understand what are the problems that are making the customers unsatisfied and work to solve this 
problems. */

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q3] Are customers getting more dissatisfied over time?

Hint: Need the percentage of different types of customer feedback in each quarter. Use a common table expression and
	  determine the number of customer feedback in each category as well as the total number of customer feedback in each quarter.
	  Now use that common table expression to find out the percentage of different types of customer feedback in each quarter.
      Eg: (total number of very good feedback/total customer feedback)* 100 gives you the percentage of very good feedback.
      
Note: For reference, refer to question number 10. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions from this question*/


WITH customer_fb AS
(
	SELECT
		quarter_number,
		customer_feedback,
		COUNT(customer_feedback) AS number_feedbacks,
		SUM(COUNT(customer_feedback)) OVER (PARTITION BY quarter_number) AS total_feedbacks
	FROM order_t
	GROUP BY 1 , 2
	ORDER BY 1
)
SELECT
	quarter_number,
	customer_feedback,
	ROUND((number_feedbacks/total_feedbacks)*100, 0) AS percentage_customer_feedback
FROM customer_fb
ORDER BY 2;

/* The Bad and Very Bad customer feedback are getting higher every quarter. In the first quarter 11% of customers gave a Bad feedback and 11% gave 
a Very Bad feedback. In the fourth quarter 29% of the customers gave a Bad rating and 31% gave a Very Bad rating. 
Together we have 60% of the customers dissatisfied at the fourth quarter.
The Good and Very Good customer feedback are getting lower every quarter. In the first quarter there were 29% Good ratings and 30% Very Good ratings. 
In the fourth quarter there were 10% Good and 10% Very Good feedback, which gives us only 20% of customers satisfied. 
The company needs to understand what are the problems that are making the customers unsatisfied and work to solve this problems.
 */


-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q4] Which are the top 5 vehicle makers preferred by the customer.

Hint: For each vehicle make what is the count of the customers.*/

SELECT
	vehicle_maker,
	COUNT(customer_id) AS number_customer_choice
FROM veh_prod_cust_v
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

/* The top 5 vehicles makers are Chevrolet, Ford, Toyota, Pontiac and Dodge.*/

-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q5] What is the most preferred vehicle make in each state?

Hint: Use the window function RANK() to rank based on the count of customers for each state and vehicle maker. 
After ranking, take the vehicle maker whose rank is 1.*/

WITH rnk_state_maker AS
(
	SELECT
		state,
		vehicle_maker,
		COUNT(customer_id) AS number_customer_choice,
		RANK() OVER (PARTITION BY state ORDER BY COUNT(customer_id) DESC) AS rnk
	FROM veh_prod_cust_v
	GROUP BY 1, 2
	ORDER BY 1, 3 DESC
)
SELECT *
FROM rnk_state_maker
WHERE rnk = 1
ORDER BY 1, 3 DESC;

/* We can see that every state has its own preferences on a vehicle maker.
In many states there is no consensus on a preferred vehicle maker. Instead, in this states we have more than one maker as preferred.
In Texas the the most preferred vehicle make is Chevrolet, in Florida is Toyota and in California we have five vehicle make tied as a first choice: Ford, Dodge, Audi, Nissan
and Chevrolet. */


-- ---------------------------------------------------------------------------------------------------------------------------------

/*QUESTIONS RELATED TO REVENUE and ORDERS 

-- [Q6] What is the trend of number of orders by quarters?

Hint: Count the number of orders for each quarter.*/

SELECT
	quarter_number,
	COUNT(order_id) AS number_of_orders
FROM order_t
GROUP BY 1
ORDER BY 1;

/* The number of orders is reducing at each quarter. In the first quarter we had 310 orders, in the second quarter the number of orders fell to 262
and in the fourth quarter we had only 199 orders. */


-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q7] What is the quarter over quarter % change in revenue? 

Hint: Quarter over Quarter percentage change in revenue means what is the change in revenue from the subsequent quarter to the previous quarter in percentage.
      To calculate you need to use the common table expression to find out the sum of revenue for each quarter.
      Then use that CTE along with the LAG function to calculate the QoQ percentage change in revenue.
      
Note: For reference, refer to question number 5. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions and the LAG function from this question.*/
      
WITH quarter_revenue AS
(
	SELECT
		quarter_number,
		SUM(calc_revenue_f(vehicle_price, discount, quantity)) AS revenue
	FROM  order_t
	GROUP BY 1
)
SELECT
	quarter_number,
	revenue,
	LAG(revenue) OVER (ORDER BY quarter_number) AS previous_quarter_revenue,
	((revenue - LAG(revenue) OVER (ORDER BY quarter_number))/LAG(revenue) OVER (ORDER BY quarter_number)) * 100 AS 'quarter_over_quarter_revenue(%)'
FROM quarter_revenue;


/* The revenue is falling every quarter. The second and third quarter have the biggest drops in revenue.
In the second quarter the revenue fell by 27% in comparison with the first quarter.
In the third quarter the revenue fell by 32% in comparison with the second quarter.
In the fourth quarter the revenue fell by 3.5% in comparison with the third quarter. The third and fourth quarter have almost the same revenue, 
with a small drop in the fourth quarter. */


-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q8] What is the trend of revenue and orders by quarters?

Hint: Find out the sum of revenue and count the number of orders for each quarter.*/

SELECT
	quarter_number,
	SUM(calc_revenue_f(vehicle_price, discount, quantity)) AS revenue,
	COUNT(order_id) number_of_orders
FROM  order_t
GROUP BY 1
ORDER BY 1;

/* The revenue and the number of orders are falling every quarter.
The third and fourth quarter have almost the same revenue, with a small drop in the fourth quarter, 
even though the number of orders in the fourth quarter is smaller than the third quarter. 
Probably in the fourth quarter some customers bought more than one car in the same order.
 */

-- ---------------------------------------------------------------------------------------------------------------------------------

/* QUESTIONS RELATED TO SHIPPING 
    [Q9] What is the average discount offered for different types of credit cards?

Hint: Find out the average of discount for each credit card type.*/

SELECT
	credit_card_type,
	AVG (discount) AS average_discount
FROM veh_ord_cust_v
GROUP BY 1
ORDER BY 2 DESC;

/* The average discount offered by the credit cards is around 60%.
The card that offered the biggest discount is Laser, with 64% of discount in average.
The card that offered the lowest discount is Diners Club International with 58% of discount in average. */

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q10] What is the average time taken to ship the placed orders for each quarters?
   Use days_to_ship_f function to compute the time taken to ship the orders.

Hint: For each quarter, find out the average of the function that you created to calculate the difference between the ship date and the order date.*/

SELECT
	quarter_number,
	AVG (days_to_ship_f(ship_date, order_date)) AS average_days_to_ship
FROM order_t
GROUP BY 1
ORDER BY 1;

/* The average days taken to ship the cars has increased in every quarter.
In the first quarter the average time to ship the order is 57 days.
In the second quarter the average time to ship the order is 71 days.
In the third quarter the average time to ship the order is 117 days.
In the fourth quarter the average time to ship the order is 174 days.
The customers satisfaction has decreased every quarter, and one of the factors is the increased time to ship the order. The customers are not happy to have to wait
longer to receive their orders. */

-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



