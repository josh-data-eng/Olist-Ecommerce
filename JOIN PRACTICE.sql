--WARMUP PRACTICE
-- How many orders are in the dataset, and how many are in each order_status?
SELECT order_status,
    COUNT(order_id) AS Total_per_Status
FROM orders
GROUP BY order_status;
-- How many customers are in each state (customer_state)? Which 5 states have the most?
SELECT customer_state,
    COUNT(customer_id) AS Total_per_State
FROM customers
GROUP BY customer_state
ORDER BY Total_per_State DESC
limit 5;
-- Which payment type is used most, and what is the total payment_value for each type?
SELECT payment_type,
    COUNT(order_id) AS Total_per_Payment_type
FROM order_payments
GROUP BY payment_type
ORDER BY Total_per_Payment_type DESC;
-- What is the distribution of review_score (how many 1s, 2s, 3s, 4s, 5s)?
SELECT review_score,
    COUNT(order_id) AS Review_per_Purchase
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;
-- Which 10 cities have the most sellers?
SELECT seller_city,
    COUNT(seller_id) AS Sellers_per_City
FROM sellers
GROUP BY seller_city
ORDER BY sellers_per_city DESC
LIMIT 10;
-- What are the 10 most expensive items sold (price)?
SELECT price AS Most_Expensive
FROM order_items
ORDER BY price DESC
LIMIT 10;
-- JOINS PRACTICE PROBLEMS
SELECT o.order_id,
    o.order_status,
    c.customer_city
FROM customers AS c
    INNER JOIN orders AS o ON c.customer_id = o.customer_id;
SELECT o.order_id,
    c.customer_state,
    o.order_status
FROM customers AS c
    INNER JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered';
SELECT p.product_id,
    p.product_category_name,
    oi.price
FROM products AS p
    INNER JOIN order_items AS oi ON p.product_id = oi.product_id;
SELECT oi.order_id,
    s.seller_id,
    s.seller_city,
    oi.price
FROM sellers AS s
    INNER JOIN order_items AS oi ON s.seller_id = oi.seller_id;
SELECT o.order_id,
    o.order_status,
    p.payment_type,
    p.payment_value
FROM orders AS o
    INNER JOIN order_payments as p ON p.order_id = o.order_id
WHERE order_status = 'canceled';
SELECT o.order_id,
    o.order_status,
    os.review_score
FROM order_reviews AS os
    INNER JOIN orders AS o ON o.order_id = os.order_id
WHERE review_score = 1;
-- 1-7
SELECT Customer_State,
    COUNT(order_id) AS Total_Order
FROM customers AS c
    INNER JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY customer_state
ORDER BY Total_Order DESC;
SELECT seller_state,
    SUM(price) AS Total_Price
FROM sellers AS s
    INNER JOIN order_items AS o ON s.seller_id = o.seller_id
GROUP BY seller_state;
SELECT product_category_name_english AS Product_Category,
    COUNT(product_id) AS Products
FROM product_category_name_translation AS pc
    INNER JOIN products AS p ON p.product_category_name = pc.product_category_name
GROUP BY product_category_name_english
ORDER BY Products DESC
LIMIT 10;
SELECT order_status,
    AVG(review_score) as Average_Score
FROM orders AS o
    INNER JOIN order_reviews AS r ON o.order_id = r.order_id
GROUP BY order_status;
SELECT p.product_category_name AS Product_Category,
    COUNT(oi.order_id) AS Items_Sold
FROM order_items AS oi
    INNER JOIN products AS p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY Items_Sold DESC
LIMIT 10;
-- 12-15
SELECT pt.product_category_name_english AS Category,
    SUM(oi.price) AS TOTAL_REVENUE
FROM order_items AS oi
    INNER JOIN products AS p ON oi.product_id = p.product_id
    INNER JOIN product_category_name_translation AS pt ON p.product_category_name = pt.product_category_name
GROUP BY pt.product_category_name_english
ORDER BY TOTAL_REVENUE DESC;
SELECT Customer_state,
    SUM(payment_value) as TOTAL
FROM customers AS c
    INNER JOIN orders AS o ON c.customer_id = o.customer_id
    INNER JOIN order_payments AS op ON o.order_id = op.order_id
GROUP BY customer_state;
SELECT Seller_City,
    COUNT(DISTINCT order_id) AS Orders
FROM order_items AS oi
    INNER JOIN sellers AS s ON oi.seller_id = s.seller_id
GROUP BY seller_city;
SELECT Customer_state,
    AVG(review_score) AS Average_Score
FROM customers AS c
    INNER JOIN orders AS o ON c.customer_id = o.customer_id
    INNER JOIN order_reviews as o_r ON o_r.order_id = o.order_id
GROUP BY customer_state;