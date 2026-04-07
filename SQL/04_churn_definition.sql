SELECT
    *,
    CASE
        WHEN recency_days > 180 THEN 'Churned'
        WHEN recency_days BETWEEN 91 AND 180 THEN 'At Risk'
        ELSE 'Active'
    END AS churn_segment
FROM vw_customer_features;

/* tạo table */
SELECT
    *,
    CASE
        WHEN recency_days > 180 THEN 1
        ELSE 0
    END AS churn_flag,
    CASE
        WHEN recency_days > 180 THEN 'Churned'
        WHEN recency_days BETWEEN 91 AND 180 THEN 'At Risk'
        ELSE 'Active'
    END AS churn_segment
INTO customer_features
FROM vw_customer_features;

/* check */
SELECT TOP 20 *
FROM customer_features;
/* check */
SELECT
    churn_segment,
    COUNT(*) AS total_customers
FROM customer_features
GROUP BY churn_segment
ORDER BY total_customers DESC;