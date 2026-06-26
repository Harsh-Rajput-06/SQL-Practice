-- ==========================================
-- ShopSphere E-Commerce Database
-- ==========================================

-- CREATE DATABASE

CREATE DATABASE shopsphere_db;

-- USE DATABASE

USE shopsphere_db;

-- Table Creation

CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(100),
	phone VARCHAR(20),
	city VARCHAR(50),
	state VARCHAR(50),
	registration_date DATE 
);

INSERT INTO customers 
(customer_id, first_name, last_name, email, phone, city, state, registration_date)
VALUES 
	(1,'Amit','Sharma','amit@gmail.com','9876543210','Delhi','Delhi','2024-01-05'),
	(2,'Priya','Verma','priya@gmail.com','9876543211','Mumbai','Maharashtra','2024-01-15'),
	(3,'Rahul','Singh','rahul@gmail.com',NULL,'Delhi','Delhi','2024-02-10'),
	(4,'Neha','Gupta','neha@gmail.com','9876543213','Pune','Maharashtra','2024-02-18'),
	(5,'Vikas','Yadav','vikas@gmail.com','9876543214','Jaipur','Rajasthan','2024-03-01'),
	(6,'Sneha','Kapoor','sneha@gmail.com',NULL,'Bangalore','Karnataka','2024-03-20'),
	(7,'Rohit','Malik','rohit@gmail.com','9876543216','Delhi','Delhi','2024-04-05'),
	(8,'Anjali','Mehta','anjali@gmail.com','9876543217','Chandigarh','Punjab','2024-04-11'),
	(9,'Karan','Arora','karan@gmail.com','9876543218','Noida','UP','2024-05-01'),
	(10,'Pooja','Jain','pooja@gmail.com','9876543219','Delhi','Delhi','2024-05-10');

CREATE TABLE categories (
	category_id INT PRIMARY KEY,
	category_name VARCHAR(50)
);

INSERT INTO Categories VALUES
	(1,'Electronics'),
	(2,'Fashion'),
	(3,'Home Appliances'),
	(4,'Books'),
	(5,'Sports');

CREATE TABLE products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100),
	category_id INT,
	price DECIMAL(10,2),
	stock_quantity INT,
	launch_date DATE,
	FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
);

INSERT INTO Products VALUES
	(101,'iPhone 15',1,80000,50,'2024-01-01'),
	(102,'Samsung S24',1,70000,40,'2024-01-05'),
	(103,'Laptop HP',1,65000,30,'2024-01-10'),
	(104,'Men T-Shirt',2,999,200,'2024-02-01'),
	(105,'Women Dress',2,1999,150,'2024-02-05'),
	(106,'Microwave Oven',3,12000,25,'2024-02-15'),
	(107,'Vacuum Cleaner',3,9000,20,'2024-03-01'),
	(108,'SQL Mastery Book',4,799,100,'2024-03-05'),
	(109,'Cricket Bat',5,2500,75,'2024-03-10'),
	(110,'Football',5,1500,80,'2024-03-15'),
	(111,'Gaming Mouse',1,2500,60,'2024-04-01'),
	(112,'Bluetooth Speaker',1,3500,45,'2024-04-10');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
	(1001,1,'2024-05-01','Delivered'),
	(1002,2,'2024-05-02','Delivered'),
	(1003,3,'2024-05-03','Cancelled'),
	(1004,1,'2024-05-05','Delivered'),
	(1005,4,'2024-05-08','Pending'),
	(1006,5,'2024-05-10','Delivered'),
	(1007,7,'2024-05-12','Delivered'),
	(1008,8,'2024-05-14','Returned'),
	(1009,9,'2024-05-15','Delivered'),
	(1010,10,'2024-05-18','Pending'),
	(1011,1,'2024-06-01','Delivered'),
	(1012,2,'2024-06-03','Delivered');

CREATE TABLE order_items (
	order_item_id INT PRIMARY KEY,
    order_id INT, 
    product_id INT,
    quantity INT,
	unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);

INSERT INTO Order_Items VALUES
	(1,1001,101,1,80000),
	(2,1001,111,2,2500),
	(3,1002,104,3,999),
	(4,1002,108,2,799),
	(5,1004,102,1,70000),
	(6,1005,106,1,12000),
	(7,1006,109,2,2500),
	(8,1007,105,1,1999),
	(9,1008,110,2,1500),
	(10,1009,103,1,65000),
	(11,1010,112,1,3500),
	(12,1011,101,1,80000),
	(13,1012,104,5,999);

CREATE TABLE payments (
	payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(30),
    payment_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);

INSERT INTO Payments VALUES
	(1,1001,'2024-05-01','UPI',85000,'Success'),
	(2,1002,'2024-05-02','Credit Card',4595,'Success'),
	(3,1004,'2024-05-05','Net Banking',70000,'Success'),
	(4,1005,'2024-05-08','UPI',12000,'Pending'),
	(5,1006,'2024-05-10','Debit Card',5000,'Success'),
	(6,1007,'2024-05-12','UPI',1999,'Success'),
	(7,1008,'2024-05-14','Credit Card',3000,'Refunded'),
	(8,1009,'2024-05-15','Net Banking',65000,'Success'),
	(9,1010,'2024-05-18','UPI',3500,'Pending'),
	(10,1011,'2024-06-01','Credit Card',80000,'Success'),
	(11,1012,'2024-06-03','UPI',4995,'Success');

-- Display all tables
SHOW TABLES;

-- ==========================================
-- BASIC SQL PRACTICE
-- ==========================================

-- Q1
-- Display all columns from Customers.
SELECT * FROM customers;

-- Q2
-- Display only first_name, city from Customers.
SELECT first_name, city FROM customers;

-- Q3
-- Show all unique cities where customers live.
SELECT DISTINCT(city) FROM customers;

-- Q4
-- Find all customers from Delhi.
SELECT CONCAT(first_name, ' ', last_name) AS customer_name
FROM customers
WHERE city = 'Delhi';

-- Q5
-- Find all customers from Delhi or Mumbai.
SELECT city,CONCAT(first_name, ' ', last_name) AS customer_name
FROM customers
WHERE city = 'Delhi' OR city = 'Mumbai';

-- Q6
-- Show customers registered after '2024-03-01'.
SELECT first_name, registration_date
FROM customers
WHERE registration_date > '2024-03-01';

-- Q7
-- Display products with price greater than 5000.
SELECT product_name, price
FROM products
WHERE price > 5000;

-- Q8
-- Find products priced between 2000 and 15000.
SELECT product_name, price
FROM products
WHERE price BETWEEN 2000 AND 15000;

-- Q9
-- Show all delivered orders.
SELECT order_id, order_status
FROM orders 
WHERE order_status = 'Delivered';

-- Q10
-- Find all payments with status 'Pending'.
SELECT payment_id, payment_status
FROM payments
WHERE payment_status = 'Pending';

-- Section B: ORDER BY, LIMIT

-- Q11
-- Display products sorted by price ascending.
SELECT product_id, price
FROM products
ORDER BY price;

-- Q12
-- Display products sorted by price descending.
SELECT product_id, price 
FROM products
ORDER BY price DESC;

-- Q13
-- Show the most expensive product.
SELECT product_id, price
FROM products
ORDER BY price DESC 
LIMIT 1;

-- Q14
-- Show the 3 cheapest products.
SELECT product_id, price
FROM products
ORDER BY price
LIMIT 3;

-- Q15
-- Display the latest 5 customer registrations.
SELECT first_name, registration_date
FROM customers
ORDER BY registration_date DESC
LIMIT 5;

-- Section C: LIKE

-- Q16
-- Find customers whose first name starts with 'A'.
SELECT first_name
FROM customers
WHERE first_name LIKE 'A%';

-- Q17
-- Find customers whose first name ends with 'a'.
SELECT first_name
FROM customers
WHERE first_name LIKE '%a';

-- Q18
-- Find products containing the word 'Book'.
SELECT product_name
FROM products
WHERE product_name LIKE '%Book%';

-- Q19
-- Find customers whose email contains 'gmail'.
SELECT first_name, email
FROM customers
WHERE email LIKE '%gmail%';

-- Q20
-- Find products whose name starts with 'S'.
SELECT product_name
FROM products
WHERE product_name LIKE 'S%';


-- Section D: IN, BETWEEN, NULL

-- Q21
-- Find customers from Delhi, Jaipur, and Pune.
SELECT first_name, city
FROM customers
WHERE city IN ('Delhi', 'Jaipur', 'Pune');

-- Q22
-- Find products launched between '2024-02-01' and '2024-03-31'.
SELECT product_name, launch_date
FROM products
WHERE launch_date BETWEEN '2024-02-01' AND '2024-03-31';

-- Q23
-- Find customers whose phone number is NULL.
SELECT first_name, phone
FROM customers
WHERE phone IS NULL;

-- Q24
-- Find orders placed between '2024-05-01' and '2024-05-15'.
SELECT order_id, order_date
FROM orders
WHERE order_date BETWEEN '2024-05-01' AND '2024-05-15';

-- Q25
-- Find payments whose amount is between 5000 and 80000.
SELECT payment_id, payment_amount
FROM payments
WHERE payment_amount BETWEEN 5000 AND 80000;

-- Section E: Aliases

-- Q26
-- Display customer names as Customer_Name.
SELECT CONCAT(first_name, ' ', last_name) AS Customer_Name
FROM customers;

-- Q27
-- Display product price as Product_Price.
SELECT price AS Product_Price
FROM products;

-- Q28
-- Display payment_amount as Revenue.
SELECT payment_amount AS Revenue
FROM payments;

-- Q29
-- Show order_date as Order_Date.
SELECT order_date AS Order_Date
FROM orders;

-- Q30
-- Display category_name as Category.
SELECT category_name AS Category
FROM categories;

-- Section F: Aggregate Functions

-- Q31
-- Count total customers.
SELECT COUNT(*) AS total_customers
FROM customers;

-- Q32
-- Count total products.
SELECT COUNT(product_id) AS total_products
FROM products;

-- Q33
-- Find maximum product price.
SELECT MAX(price) AS Maximum_Price
FROM products;

-- Q34
-- Find minimum product price.
SELECT MIN(price) AS Minimum_price
FROM products;

-- Q35
-- Find average product price.
SELECT AVG(price) AS avg_price
FROM products;

-- Q36
-- Find total stock available.
SELECT SUM(stock_quantity) AS total_stock
FROM products;

-- Q37
-- Find total payment amount received.
SELECT SUM(payment_amount) AS Total_amount
FROM payments
WHERE payment_status = 'Success';

-- Q38
-- Count successful payments.
SELECT COUNT(payment_status)
FROM payments
WHERE payment_status = 'Success';

-- Q39
-- Find total number of orders.
SELECT COUNT(order_id) AS Total_orders
FROM orders;

-- Q40
-- Find average payment amount.
SELECT AVG(payment_amount) AS avg_payment
FROM payments;

-- Section G: GROUP BY

-- Q41
-- Count customers city-wise.
SELECT city, COUNT(*) AS Total_customer
FROM customers
GROUP BY city;

-- Q42
-- Count products category-wise.
SELECT category_id, COUNT(*) AS PRODUCTS
FROM products
GROUP BY category_id;

-- Q43
-- Calculate total stock category-wise.
SELECT category_id, SUM(stock_quantity) AS Total_stock
FROM products
GROUP BY category_id;

-- Q44
-- Count orders status-wise.
SELECT order_status, COUNT(*) AS orders
FROM orders
GROUP BY order_status;

-- Q45
-- Calculate total payment amount by payment method.
SELECT payment_method, SUM(payment_amount) AS total_amount
FROM payments
GROUP BY payment_method;

-- Q46
-- Find average product price by category.
SELECT category_id, AVG(price) AS avg_price
FROM products
GROUP BY category_id;

-- Q47
-- Count registrations month-wise.
SELECT MONTH(registration_date) AS month , COUNT(*) AS registrations
FROM customers
GROUP BY MONTH(registration_date);

-- Q48
-- Find total products launched each month.
SELECT MONTH(launch_date) AS month, COUNT(*) AS total_products_launched
FROM products
GROUP BY MONTH(launch_date);

-- Q49
-- Count payments status-wise.
SELECT payment_status, COUNT(*) AS payments
FROM payments
GROUP BY payment_status;

-- Q50
-- Calculate total revenue by payment status.
SELECT payment_status, SUM(payment_amount) AS total_revenue
FROM payments
GROUP BY payment_status;

-- Section H: HAVING

-- Q51
-- Show cities having more than 2 customers.
SELECT city, COUNT(*) AS total_customer
FROM customers
GROUP BY city
HAVING COUNT(customer_id) > 2;

-- Q52
-- Show categories having more than 2 products.
SELECT category_id, COUNT(*) AS total_product
FROM products
GROUP BY category_id
HAVING COUNT(category_id) > 2;

-- Q53
-- Show payment methods with total revenue greater than 50000.
SELECT payment_method, SUM(payment_amount) AS Total_revenue
FROM payments
GROUP BY payment_method
HAVING SUM(payment_amount) > 50000;

-- Q54
-- Show months having more than 2 customer registrations.
SELECT MONTH(registration_date) AS month, COUNT(*) AS Total_registrations
FROM customers
GROUP BY MONTH(registration_date)
HAVING COUNT(registration_date) > 2;

-- Q55
-- Show order statuses occurring more than once.
SELECT order_status, COUNT(order_status) AS total_order_status
FROM orders
GROUP BY order_status
HAVING COUNT(order_status) > 1;

-- Section I: String Functions

-- Q56
-- Display customer full names using CONCAT().
SELECT CONCAT(first_name, ' ' , last_name) AS full_name
FROM customers;

-- Q57
-- Convert customer names to uppercase.
SELECT UPPER(first_name) AS upper_case_name
FROM customers;

-- Q58
-- Convert product names to lowercase.
SELECT LOWER(product_name) AS lower_case_name
FROM products;

-- Q59
-- Display length of each product name.
SELECT product_name, LENGTH(product_name) AS product_name_length
FROM products;

-- Q60
-- Show first 3 characters of each customer name.
SELECT LEFT(first_name, 3)
FROM customers;

-- Section J: Date Functions

-- Q61
-- Show current date.
SELECT CURDATE();

-- Q62
-- Find number of days since each customer registered.
SELECT first_name,
       DATEDIFF(CURDATE(), registration_date) AS days_since_registration
FROM customers;

-- Q63
-- Extract month from order_date.
SELECT MONTHNAME(order_date) AS month
FROM orders;

-- Q64
-- Extract year from payment_date.
SELECT YEAR(payment_date) AS year
FROM payments;

-- Q65
-- Find customers registered in January.
SELECT first_name, MONTHNAME(registration_date) AS registered_month
FROM customers
WHERE MONTHNAME(registration_date) = 'January';

-- Q66
-- Find orders placed in May.
SELECT order_id, MONTHNAME(order_date) AS placed_order
FROM orders
WHERE MONTHNAME(order_date) = 'May';

-- Q67
-- Calculate total orders month-wise.
SELECT MONTHNAME(order_date) AS Month, COUNT(order_id) AS total_order
FROM orders
GROUP BY MONTHNAME(order_date);

-- Q68
-- Show products launched in Q1 (Jan–Mar).
SELECT product_name, MONTHNAME(launch_date) AS date
FROM products
WHERE MONTHNAME(launch_date) IN( 'January', 'February', 'March');

-- Q69
-- Find oldest customer registration.
SELECT first_name, registration_date
FROM customers
ORDER BY registration_date LIMIT 1;

-- Q70
-- Find newest customer registration.
SELECT first_name, registration_date
FROM customers
ORDER BY registration_date DESC LIMIT 1;