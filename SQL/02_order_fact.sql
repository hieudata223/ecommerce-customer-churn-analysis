/*1. Aggregate order_items theo order_id*/
WITH item_summary AS (
    SELECT
        oi.order_id,
        COUNT(*) AS total_items,
        SUM(oi.price) AS total_item_value,
        SUM(oi.freight_value) AS total_freight_value
    FROM dbo.order_items as oi
    GROUP BY oi.order_id
)
SELECT order_id, total_items,total_item_value,total_freight_value
FROM item_summary;

/*2. Aggregate payments theo order_id*/
WITH payment_summary AS (
    SELECT
        p.order_id,
        SUM(p.payment_value) AS total_payment_value
    FROM payments p
    GROUP BY p.order_id
)
SELECT TOP 10 *
FROM payment_summary;

/*3. Lấy review score theo order_id*/
WITH review_summary AS (
    SELECT
        r.order_id,
        AVG(CAST(r.review_score AS FLOAT)) AS avg_review_score
    FROM reviews r
    GROUP BY r.order_id
)
SELECT TOP 10 *
FROM review_summary;

/*.4. Join lại thành order_fact*/
WITH item_summary AS (
    SELECT
        oi.order_id,
        COUNT(*) AS total_items,
        SUM(oi.price) AS total_item_value,
        SUM(oi.freight_value) AS total_freight_value
    FROM order_items oi
    GROUP BY oi.order_id
),
payment_summary AS (
    SELECT
        p.order_id,
        SUM(p.payment_value) AS total_payment_value
    FROM payments p
    GROUP BY p.order_id
),
review_summary AS (
    SELECT
        r.order_id,
        AVG(CAST(r.review_score AS FLOAT)) AS avg_review_score
    FROM reviews r
    GROUP BY r.order_id
)
SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    i.total_items,
    i.total_item_value,
    i.total_freight_value,
    p.total_payment_value,
    r.avg_review_score
FROM orders as  o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
LEFT JOIN item_summary i
    ON o.order_id = i.order_id
LEFT JOIN payment_summary p
    ON o.order_id = p.order_id
LEFT JOIN review_summary r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered';


/*thêm delivery metrics*/
WITH item_summary AS (
    SELECT
        oi.order_id,
        COUNT(*) AS total_items,
        SUM(oi.price) AS total_item_value,
        SUM(oi.freight_value) AS total_freight_value
    FROM order_items oi
    GROUP BY oi.order_id
),
payment_summary AS (
    SELECT
        p.order_id,
        SUM(p.payment_value) AS total_payment_value
    FROM payments p
    GROUP BY p.order_id
),
review_summary AS (
    SELECT
        r.order_id,
        AVG(CAST(r.review_score AS FLOAT)) AS avg_review_score
    FROM reviews r
    GROUP BY r.order_id
)
SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    i.total_items,
    i.total_item_value,
    i.total_freight_value,
    p.total_payment_value,
    r.avg_review_score,
    DATEDIFF(DAY, o.order_purchase_timestamp, o.order_delivered_customer_date) AS delivery_days,
    DATEDIFF(DAY, o.order_estimated_delivery_date, o.order_delivered_customer_date) AS delivery_delay_days,
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
        ELSE 0
    END AS is_late_delivery
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
LEFT JOIN item_summary i
    ON o.order_id = i.order_id
LEFT JOIN payment_summary p
    ON o.order_id = p.order_id
LEFT JOIN review_summary r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered';

/* lưu thành View*/
CREATE VIEW vw_order_fact AS
WITH item_summary AS (
    SELECT
        oi.order_id,
        COUNT(*) AS total_items,
        SUM(oi.price) AS total_item_value,
        SUM(oi.freight_value) AS total_freight_value
    FROM order_items oi
    GROUP BY oi.order_id
),
payment_summary AS (
    SELECT
        p.order_id,
        SUM(p.payment_value) AS total_payment_value
    FROM payments p
    GROUP BY p.order_id
),
review_summary AS (
    SELECT
        r.order_id,
        AVG(CAST(r.review_score AS FLOAT)) AS avg_review_score
    FROM reviews r
    GROUP BY r.order_id
)
SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    i.total_items,
    i.total_item_value,
    i.total_freight_value,
    p.total_payment_value,
    r.avg_review_score,
    DATEDIFF(DAY, o.order_purchase_timestamp, o.order_delivered_customer_date) AS delivery_days,
    DATEDIFF(DAY, o.order_estimated_delivery_date, o.order_delivered_customer_date) AS delivery_delay_days,
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
        ELSE 0
    END AS is_late_delivery
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
LEFT JOIN item_summary i
    ON o.order_id = i.order_id
LEFT JOIN payment_summary p
    ON o.order_id = p.order_id
LEFT JOIN review_summary r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered';

SELECT TOP 20 * FROM vw_order_fact;