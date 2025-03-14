WITH customer_activity AS (
    SELECT
        CUSTOMER_ID,
        MIN(PAYMENT_MONTH) AS first_payment_month,
        MAX(PAYMENT_MONTH) AS last_payment_month
    FROM {{ ref('stg_transactions') }}
    GROUP BY CUSTOMER_ID
),
churned_and_new_customers AS (
    SELECT
        DATE_TRUNC('month', TO_DATE(first_payment_month, 'YYYY-MM')) AS month,
        COUNT(DISTINCT CASE WHEN first_payment_month = last_payment_month THEN CUSTOMER_ID END) AS new_customers,
        COUNT(DISTINCT CASE WHEN TO_DATE(last_payment_month, 'YYYY-MM') < CURRENT_DATE - INTERVAL '6 months' THEN CUSTOMER_ID END) AS churned_customers
    FROM customer_activity
    GROUP BY DATE_TRUNC('month', TO_DATE(first_payment_month, 'YYYY-MM'))
)
SELECT * FROM churned_and_new_customers;