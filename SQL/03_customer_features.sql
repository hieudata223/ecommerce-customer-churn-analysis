WITH max_date AS (
    SELECT MAX(order_purchase_timestamp) AS max_purchase_date
    FROM vw_order_fact
)
SELECT
    vf.customer_unique_id,
    MIN(vf.order_purchase_timestamp) AS first_purchase_date,
    MAX(vf.order_purchase_timestamp) AS last_purchase_date,
    COUNT(DISTINCT vf.order_id) AS total_orders,
    SUM(vf.total_items) AS total_items,
    SUM(vf.total_payment_value) AS total_spent,
    ROUND(SUM(vf.total_payment_value) * 1.0 / COUNT(DISTINCT vf.order_id), 2) AS avg_order_value,
    ROUND(AVG(vf.avg_review_score), 2) AS avg_review_score,
    ROUND(AVG(CAST(vf.delivery_days AS FLOAT)), 2) AS avg_delivery_days,
    ROUND(AVG(CAST(vf.delivery_delay_days AS FLOAT)), 2) AS avg_delivery_delay_days,
    ROUND(AVG(CAST(vf.is_late_delivery AS FLOAT)), 4) AS late_delivery_rate,
    DATEDIFF(
        DAY,
        MAX(vf.order_purchase_timestamp),
        (SELECT max_purchase_date FROM max_date)
    ) AS recency_days
FROM vw_order_fact vf
GROUP BY vf.customer_unique_id;

/* lưu thanhf view test logic */
CREATE VIEW vw_customer_features AS
WITH max_date AS (
    SELECT MAX(order_purchase_timestamp) AS max_purchase_date
    FROM vw_order_fact
)
SELECT
    vf.customer_unique_id,
    MIN(vf.order_purchase_timestamp) AS first_purchase_date,
    MAX(vf.order_purchase_timestamp) AS last_purchase_date,
    COUNT(DISTINCT vf.order_id) AS total_orders,
    SUM(vf.total_items) AS total_items,
    SUM(vf.total_payment_value) AS total_spent,
    ROUND(SUM(vf.total_payment_value) * 1.0 / COUNT(DISTINCT vf.order_id), 2) AS avg_order_value,
    ROUND(AVG(CAST(vf.avg_review_score AS FLOAT)), 2) AS avg_review_score,
    ROUND(AVG(CAST(vf.delivery_days AS FLOAT)), 2) AS avg_delivery_days,
    ROUND(AVG(CAST(vf.delivery_delay_days AS FLOAT)), 2) AS avg_delivery_delay_days,
    ROUND(AVG(CAST(vf.is_late_delivery AS FLOAT)), 4) AS late_delivery_rate,
    DATEDIFF(
        DAY,
        MAX(vf.order_purchase_timestamp),
        (SELECT max_purchase_date FROM max_date)
    ) AS recency_days
FROM vw_order_fact vf
GROUP BY vf.customer_unique_id;

SELECT TOP 20 * 
FROM vw_customer_features
ORDER BY total_spent DESC;