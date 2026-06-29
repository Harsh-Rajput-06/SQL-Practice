USE shopsphere_db;

-- Section A: INNER JOIN (Q71–Q80)

-- Q71
-- Display each order along with the customer's full name.
SELECT CONCAT(first_name, ' ' , last_name) AS Customer_name, o.order_id
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id;

-- Q72
-- Display each order along with its payment method and payment status.
SELECT o.order_id, p.payment_method, p.payment_status
FROM payments AS p 
INNER JOIN orders AS o ON p.order_id = o.order_id;

-- Q73
-- Show product name, category name, and price.
SELECT p.product_name, p.price, c.category_name
FROM products AS p
INNER JOIN categories AS c ON p.category_id = c.category_id;

-- Q74
-- Display order ID, customer name, and order status.
SELECT c.first_name, o.order_id, o.order_status
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id;

-- Q75
-- Display order ID, product name, quantity, and unit price.
SELECT o.order_id, p.product_name, oi.quantity, oi.unit_price
FROM orders AS o
INNER JOIN order_items AS oi ON o.order_id = oi.order_id
INNER JOIN products AS p ON oi.product_id = p.product_id;

-- Q76
-- Display customer name, order date, and payment amount.
SELECT CONCAT(first_name, ' ', last_name) AS customer_name, o.order_date, p.payment_amount
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
INNER JOIN payments AS p ON o.order_id = p.order_id;

-- Q77
-- Show product name, category name, stock quantity, and launch date.
SELECT p.product_name, p.stock_quantity, p.launch_date, c.category_name
FROM products AS p
INNER JOIN categories AS c ON p.category_id = c.category_id;

-- Q78
-- Display order ID, customer name, product name, and quantity.
SELECT CONCAT(first_name, ' ', last_name) AS customer_name, o.order_id, p.product_name, oi.quantity
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi ON o.order_id = oi.order_id
INNER JOIN products AS p ON oi.product_id = p.product_id;

-- Q79
-- Show payment ID, customer name, payment method, payment amount, and payment status.
SELECT CONCAT(first_name, ' ', last_name) AS customer_name, p.payment_id, p.payment_method, p.payment_amount, p.payment_status
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
INNER JOIN payments AS p ON o.order_id = p.order_id;

-- Q80
-- Display customer city, order ID, order status, and payment status.
SELECT c.city, o.order_id, o.order_status, p.payment_status
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
INNER JOIN payments AS p ON o.order_id = p.order_id;

-- Section B: LEFT / RIGHT / SELF / CROSS JOIN (Q81–Q90)

-- Q81
-- Find all customers and their orders. Include customers who never placed an order.
SELECT CONCAT(c.first_name, ' ' , c.last_name) AS customer_name, o.order_id
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id;

-- Q82
-- Find all products and their order quantities. Include products that were never ordered.
SELECT p.product_id, p.product_name, oi.quantity
FROM products AS p
LEFT JOIN order_items AS oi ON p.product_id = oi.product_id;

-- Q83
-- Find all categories and their products. Include categories with no products.
SELECT c.category_name, p.product_name
FROM categories AS c
LEFT JOIN products AS p ON c.category_id = p.category_id;

-- Q84
-- Find all orders and payments. Include orders that don't have a payment record.
SELECT o.order_id, p.payment_id
FROM orders AS o
LEFT JOIN payments AS p ON o.order_id = p.order_id;

-- Q85
-- Find all payments even if an order doesn't exist (RIGHT JOIN practice).
SELECT o.order_id, o.order_status, p.payment_id, p.payment_method, p.payment_amount, p.payment_status
FROM orders AS o
RIGHT JOIN payments AS p ON o.order_id = p.order_id;

-- Q86
-- Perform a SELF JOIN on Customers to show customers living in the same city.
-- (Do not pair a customer with themselves.)
SELECT c1.customer_id, c1.first_name, c2.customer_id, c2.first_name, c1.city
FROM customers AS c1
INNER JOIN customers AS c2 ON c1.city = c2.city AND c1.customer_id > c2.customer_id
ORDER BY c1.city;

-- Q87
-- Create every possible combination of customers and categories using CROSS JOIN.
SELECT c.customer_id, c.first_name, ca.category_name
FROM customers AS c
CROSS JOIN categories AS ca;

-- Q88
-- Create every possible combination of products and payment methods.
SELECT p.product_name, pm.payment_method
FROM Products p
CROSS JOIN (SELECT DISTINCT payment_method FROM Payments) pm;

-- Q89
-- Find customers who have never placed an order.
SELECT c.first_name, c.last_name
FROM Customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Q90
-- Find products that have never been ordered.
SELECT p.product_name
FROM products AS p
LEFT JOIN order_items AS oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;

-- Section C: CASE WHEN (Q91–Q100)

-- Q91
-- Label products as:
-- Expensive (>50000)
-- Medium (5000–50000)
-- Affordable (<5000)
SELECT product_name, price,
	CASE
		WHEN price > 50000 THEN 'expensive'
		WHEN price BETWEEN 5000 AND 50000 THEN 'Medium'
		WHEN price < 5000 THEN 'Affordable'
	END AS product_label
FROM products;

-- Q92
-- Classify customers:
-- New (Registered after 2024-03-01)
-- Existing (Otherwise)
SELECT first_name, registration_date,
	CASE
		WHEN registration_date > '2024-03-01' THEN 'New'
        ELSE 'Existing'
	END AS Customer_registered
FROM customers;

-- Q93
-- Convert payment status into:
-- Paid
-- Pending
-- Refunded
SELECT payment_status,
	CASE 
		WHEN payment_status = 'Success' THEN 'Paid'
        WHEN payment_status = 'Pending' THEN 'Pending'
        WHEN payment_status = 'Refunded' THEN 'Refunded'
	END AS new_payment_status
FROM payments;

-- Q94
-- Show product price along with:
-- Premium
-- Standard
-- Budget
SELECT product_name, price,
	CASE
		WHEN price > 50000 THEN 'Premium'
        WHEN price BETWEEN 5000 AND 50000 THEN 'Standard'
        WHEN price < 5000 THEN 'Budget'
	END AS product_category
FROM products;

-- Q95
-- Classify orders:
-- Completed
-- In Progress
-- Cancelled
SELECT order_status,
	CASE 
		WHEN order_status = 'Delivered' THEN 'Completed'
        WHEN order_status = 'Pending' THEN 'In Progress'
        ELSE order_status
	END AS order_label
FROM orders;
        
-- Q96
-- Display payment amount and classify:
-- High Value
-- Medium Value
-- Low Value
SELECT payment_amount,
	CASE 
		WHEN payment_amount > 50000 THEN 'High Value'
        WHEN payment_amount BETWEEN 5000 AND 50000 THEN 'Medium Value'
        WHEN payment_amount < 5000 THEN 'Low Value'
	END AS payment_classification
FROM payments;

-- Q97
-- Show stock status:
-- In Stock
-- Low Stock
-- Out of Stock
SELECT stock_quantity,
	CASE 
		WHEN stock_quantity > 50 THEN 'In Stock'
        WHEN stock_quantity BETWEEN 1 AND 50 THEN 'Low Stock'
        WHEN stock_quantity = 0 THEN 'Out of Stock'
	END AS stock_status
FROM products;

-- Q98
-- Display customer city and classify:
-- Metro
-- Non-Metro
SELECT city,
	CASE
		WHEN city IN ('Delhi', 'Noida', 'Pune', 'Bangalore') THEN 'Metro'
        ELSE 'Non-Metro'
	END AS city_classification
FROM customers;

-- Q99
-- Display order month and classify:
-- Peak Season
-- Normal Season
SELECT order_id, order_date, MONTHNAME(order_date) AS order_month,
	CASE 
		WHEN MONTH(order_date) IN (11, 12) THEN 'Peak Season'
        ELSE 'Normal Season'
	END AS season_classification
FROM orders;

-- Q100
-- Display customer names and classify:
-- Delhi Customer
-- Other Customer
SELECT first_name,city,
	CASE
		WHEN city = 'Delhi' THEN 'Delhi Customer'
        ELSE 'Other Customer'
	END AS Delhi_customer
FROM customers;

-- Section D: UNION / UNION ALL (Q101–Q105)

-- Q101
-- Create a single list containing all customer names and product names.
SELECT CONCAT(first_name, ' ' , last_name) AS customer_name FROM customers
UNION
SELECT product_name FROM products;

-- Q102
-- Display all cities from Customers and category names in one result.
SELECT city FROM customers
UNION 
SELECT category_name FROM categories;

-- Q103
-- Display all order dates and payment dates together.
SELECT order_date FROM orders
UNION
SELECT payment_date FROM payments;

-- Q104
-- Show all customer IDs and order IDs in one result.
SELECT customer_id FROM customers
UNION
SELECT order_id FROM orders;

-- Q105
-- Repeat Q101 using UNION ALL.
SELECT CONCAT(first_name, ' ' , last_name) AS customer_name FROM customers
UNION ALL
SELECT product_name FROM products;

-- Section E: Subqueries (Q106–Q115)

-- Q106
-- Find the most expensive product.
SELECT product_name AS most_expensive_product, price
FROM products
WHERE price = 
	(SELECT MAX(price) FROM products);

-- Q107
-- Find customers who placed the earliest order.
SELECT c.customer_id, c.first_name, o.order_date
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.order_date = 
(SELECT order_date FROM orders ORDER BY order_date LIMIT 1);

-- OR

SELECT c.customer_id, c.first_name, o.order_date
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.order_date = 
(SELECT MIN(order_date) FROM orders);

-- Q108
-- Find products priced above the average product price.
SELECT product_name, price
FROM products
WHERE price >
(SELECT AVG(price) FROM products);

-- Q109
-- Find orders whose payment amount is above average.
SELECT order_id, payment_amount
FROM payments
WHERE payment_amount >
(SELECT AVG(payment_amount) FROM payments);

-- Q110
-- Find customers who placed more than one order.
SELECT *
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    GROUP BY customer_id
    HAVING COUNT(*) > 1
);

-- Q111
-- Find products belonging to the category "Electronics".
SELECT p.product_name, c.category_name
FROM products AS p
INNER JOIN categories AS c ON p.category_id = c.category_id
WHERE category_name IN
(SELECT category_name FROM categories WHERE category_name = 'Electronics');

-- Q112
-- Find customers who made successful payments.
SELECT c.customer_id, c.first_name, o.order_id, p.payment_status
FROM orders AS o
INNER JOIN payments AS p ON o.order_id = p.order_id
INNER JOIN customers AS c ON o.customer_id = c.customer_id
WHERE payment_status IN 
(SELECT payment_status FROM payments WHERE payment_status = 'Success');

-- Q113
-- Find orders having the maximum payment amount.
SELECT order_id, payment_amount
FROM payments
WHERE payment_amount =
(SELECT MAX(payment_amount) FROM payments);

-- Q114
-- Find products with stock greater than average stock.
SELECT product_name, stock_quantity
FROM products
WHERE stock_quantity >
(SELECT AVG(stock_quantity) FROM products);

-- Q115
-- Find customers who registered before the average registration date.
SELECT customer_id, first_name, registration_date
FROM customers
WHERE registration_date <
(SELECT AVG(registration_date) FROM customers);

-- Section F: Correlated Subqueries (Q116–Q120)

-- Q116
-- Find customers whose total payment is greater than the average payment of all customers.
SELECT c1.customer_id, c1.first_name
FROM customers AS c1
WHERE (
    SELECT SUM(p.payment_amount)
    FROM orders AS o
    INNER JOIN payments AS p
      ON o.order_id = p.order_id
    WHERE o.customer_id = c1.customer_id
) >
(
    SELECT AVG(payment_amount)
    FROM Payments
);

-- Q117
-- Find products priced above the average price of their own category.
SELECT p1.product_name, p1.price, c1.category_name
FROM products AS p1
INNER JOIN categories AS c1 ON p1.category_id = c1.category_id
WHERE p1.price >
(SELECT AVG(p2.price) FROM products AS p2
WHERE p2.category_id = p1.category_id);

-- Q118
-- Find categories whose average product price is greater than the overall average product price.
SELECT c1.category_name, AVG(p1.price) AS category_avg
FROM products AS p1
INNER JOIN categories AS c1 ON p1.category_id = c1.category_id
GROUP BY c1.category_id, c1.category_name
HAVING AVG(p1.price) > 
(SELECT AVG(p2.price) FROM products AS p2
);

-- Q119
-- Find customers who placed the maximum number of orders in their city.
SELECT c.customer_id, c.first_name, c.city
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.city
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*)
    FROM customers c2
    JOIN orders o2 ON c2.customer_id = o2.customer_id
    WHERE c2.city = c.city
    GROUP BY c2.customer_id
);

-- Q120
-- Find products whose total sales quantity is above the average sales quantity.
SELECT p.product_name
FROM products AS p
JOIN Order_Items AS oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) >
(
    SELECT AVG(total_qty)
    FROM (
        SELECT SUM(quantity) AS total_qty
        FROM Order_Items
        GROUP BY product_id
    ) t
);

-- Section G: CTEs (Q121–Q125)

-- Q121
-- Using a CTE, calculate total revenue generated by each customer.
WITH CustomerRevenue AS (
	SELECT o.customer_id, SUM(p.payment_amount) AS total_revenue
    FROM orders AS o
    INNER JOIN payments AS p ON o.order_id = p.order_id
    GROUP BY o.customer_id
)
SELECT c.customer_id, c.first_name, cr.total_revenue
FROM customers AS c
INNER JOIN CustomerRevenue AS cr ON c.customer_id = cr.customer_id
ORDER BY cr.total_revenue DESC;

-- Q122
-- Using a CTE, find the top 5 customers by total payment.
WITH TotalPayment AS (
	SELECT o.customer_id, SUM(p.payment_amount) AS total_payment
    FROM orders AS o
    INNER JOIN payments AS p ON o.order_id = p.order_id
    GROUP BY o.customer_id
)
SELECT c.customer_id, c.first_name, tp.total_payment
FROM customers AS c
INNER JOIN TotalPayment AS tp ON c.customer_id = tp.customer_id
ORDER BY tp.total_payment DESC 
LIMIT 5;

-- Q123
-- Using a CTE, calculate category-wise revenue.
WITH CategoryRevenue AS (
	SELECT SUM(oi.quantity * oi.unit_price) AS total_payment, pr.category_id
    FROM order_items AS oi
    INNER JOIN products AS pr ON oi.product_id = pr.product_id
    GROUP BY pr.category_id
)
SELECT c.category_name, COALESCE(cr.total_payment, 0) AS total_payment
FROM categories AS c
LEFT JOIN CategoryRevenue AS cr ON c.category_id = cr.category_id
ORDER BY c.category_name;

-- Q124
-- Using a CTE, calculate monthly revenue.
WITH MonthlyRevenue AS (
	SELECT MONTH(payment_date) AS revenue_month, SUM(payment_amount) AS total_payment
    FROM payments
    WHERE payment_status = 'Success'
    GROUP BY MONTH(payment_date)
)
SELECT revenue_month, total_payment 
FROM MonthlyRevenue
ORDER BY revenue_month DESC;

-- Q125
-- Using a CTE, find customers whose spending is above average.
WITH CustomerTotals AS (
	SELECT SUM(p.payment_amount) AS total_spend, o.customer_id
    FROM payments AS p
    INNER JOIN orders AS o ON p.order_id = o.order_id
    GROUP BY o.customer_id
)
SELECT c.customer_id, c.first_name, ct.total_spend
FROM customers AS c
INNER JOIN CustomerTotals AS ct ON c.customer_id = ct.customer_id
WHERE ct.total_spend > (SELECT AVG(total_spend) FROM CustomerTotals)
ORDER BY ct.total_spend DESC;


-- Section H: Business Case Studies (Q126–Q140)

-- Q126
-- Find the top 5 highest spending customers.
WITH CustomerSpending AS (
	SELECT o.customer_id, SUM(p.payment_amount) AS total_spending
	FROM orders AS o
    INNER JOIN payments AS p ON o.order_id = p.order_id
    WHERE p.payment_status = 'Success'
    GROUP BY o.customer_id
)
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, cs.total_spending
FROM customers AS c
INNER JOIN CustomerSpending AS cs ON c.customer_id = cs.customer_id
ORDER BY cs.total_spending DESC
LIMIT 5;

-- Q127
-- Calculate category-wise revenue.
SELECT c.category_id, c.category_name, SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM categories AS c
INNER JOIN products AS p ON c.category_id = p.category_id
INNER JOIN order_items AS oi ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
ORDER BY total_revenue DESC;

-- Q128
-- Find monthly sales revenue.
SELECT MONTH(o.order_date) AS order_month, YEAR(o.order_date) AS order_year, SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders AS o
INNER JOIN order_items AS oi ON o.order_id = oi.order_id
GROUP BY order_month, order_year
ORDER BY order_month, order_year;

-- Q129
-- Find the most sold product.
SELECT p.product_id, p.product_name, COUNT(pa.payment_id) AS total_sale_count
FROM products AS p
INNER JOIN order_items AS oi ON p.product_id = oi.product_id
INNER JOIN payments AS pa ON oi.order_id = pa.order_id
WHERE payment_status = 'Success'
GROUP BY p.product_id, p.product_name
ORDER BY total_sale_count DESC 
LIMIT 1;

-- Q130
-- Find the least sold product.
SELECT p.product_id, p.product_name, COUNT(pa.payment_id) AS total_sale_count
FROM products AS p
INNER JOIN order_items AS oi ON p.product_id = oi.product_id
INNER JOIN payments AS pa ON oi.order_id = pa.order_id
WHERE payment_status = 'Success'
GROUP BY p.product_id, p.product_name
ORDER BY total_sale_count 
LIMIT 1;

-- Q131
-- Calculate Average Order Value (AOV).
SELECT SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT(oi.order_id)) AS avg_order_value
FROM order_items AS oi;

-- Q132
-- Find repeat customers.
SELECT c.customer_id, c.first_name, COUNT(o.order_id) AS total_orders
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
WHERE order_status = 'Delivered'
GROUP BY c.customer_id, c.first_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;

-- Q133
-- Calculate revenue generated by each city.
SELECT c.city, SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi ON o.order_id = oi.order_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- Q134
-- Find the most popular payment method.
SELECT COUNT(p.payment_method) AS total_payment_count, p.payment_method
FROM payments AS p
WHERE payment_status = 'Success'
GROUP BY p.payment_method
ORDER BY total_payment_count DESC 
LIMIT 1;

-- Q135
-- Calculate percentage contribution of each category to total revenue.
SELECT c.category_id, c.category_name, SUM(oi.quantity * oi.unit_price) AS total_revenue, 
    ROUND(
        SUM(oi.quantity * oi.unit_price) * 100 /
        (
            SELECT SUM(quantity * unit_price)
            FROM Order_Items
        ),
        2
    ) AS revenue_percentage
FROM categories AS c
INNER JOIN products AS p ON c.category_id = p.category_id
INNER JOIN order_items AS oi ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
ORDER BY revenue_percentage DESC;

-- Q136
-- Find customers whose lifetime spending exceeds ₹1,00,000.
SELECT c.customer_id, c.first_name, SUM(p.payment_amount) AS lifetime_spending	
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
INNER JOIN payments AS p ON o.order_id = p .order_id
WHERE payment_status = 'Success'
GROUP BY c.customer_id, c.first_name
HAVING SUM(p.payment_amount) > 100000;

-- Q137
-- Find categories with declining sales.
-- Reserved for Advanced SQL (Window Functions)

-- Q138
-- Find products contributing to 80% of revenue (Pareto concept).
-- Reserved for Advanced SQL (Pareto Analysis)

-- Q139
-- Find the monthly customer acquisition trend.
-- Reserved for Advanced SQL (Customer Acquisition Trend)

-- Q140
-- Build a sales summary showing:
-- Total Orders
-- Total Revenue
-- Average Order Value
-- Successful Payments
-- Cancelled Orders
SELECT COUNT(DISTINCT o.order_id) AS total_orders, 
	SUM(oi.quantity * oi.unit_price) AS total_revenue,
	ROUND(
        SUM(oi.quantity * oi.unit_price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value,
    SUM(
        CASE
            WHEN p.payment_status = 'Success'
            THEN 1
            ELSE 0
        END
    ) AS successful_payments,
    SUM(
        CASE
            WHEN o.order_status = 'Cancelled'
            THEN 1
            ELSE 0
        END
    ) AS cancelled_orders
FROM orders AS o
INNER JOIN order_items AS oi ON o.order_id = oi.order_id
INNER JOIN payments AS p ON oi.order_id = p.order_id;

    
