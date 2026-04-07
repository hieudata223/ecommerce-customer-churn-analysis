/*Kiểm tra số dòng từng bảng */

SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*)  FROM order_items 
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'category_translation', COUNT(*) FROM category_translation;

/*kiểm tra null ở các cột */
--1 customer
SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_id) AS customer_id_not_null,
    COUNT(customer_unique_id) AS customer_unique_id_not_null
FROM customers;
--=> không có null 

--2 orders
SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id_not_null,
    COUNT(customer_id) AS customer_id_not_null,
    COUNT(order_status) AS order_status_not_null,
    COUNT(order_purchase_timestamp) AS purchase_ts_not_null
FROM orders;
--=> không có null 

-- 3 order_items
SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id_not_null,
    COUNT(product_id) AS product_id_not_null,
    COUNT(price) AS price_not_null,
    COUNT(freight_value) AS freight_not_null
FROM order_items;
--=> không có null 

-- 4 payments
SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id_not_null,
    COUNT(payment_type) AS payment_type_not_null,
    COUNT(payment_value) AS payment_value_not_null
FROM payments;
--=> không có null 

--5reviews
SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id_not_null,
    COUNT(review_score) AS review_score_not_null
FROM reviews;
--=> không có null 

/* kiểm tra duplicate key */
--orders có bị trùng order_id không
SELECT order_id, COUNT(*) AS cnt
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

--customers có bị trùng customer_id không
SELECT customer_id, COUNT(*) AS cnt
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

--reviews có thể có nhiều dòng cho 1 order, nên check để biết
SELECT order_id, COUNT(*) AS cnt
FROM reviews
GROUP BY order_id
HAVING COUNT(*) > 1;

/*Kiểm tra time range của orders*/
SELECT
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
FROM orders;

/*Kiểm tra order_status*/
SELECT order_status, COUNT(*) AS total_orders
FROM orders
Group by order_status
ORDER BY total_orders DESC;

/* CHỌN PHẠM VI DỮ LIệu CHO CHURUN ( ưu tiên những đơn đã hoàn thành)*/
SELECT COUNT(*) AS delivered_orders
FROM orders
WHERE order_status = 'delivered';