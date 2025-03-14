WITH revenue_analysis AS (
    SELECT
        CUSTOMER_ID,
        DATE_TRUNC('month', TO_DATE(PAYMENT_MONTH)) AS month,
        SUM(REVENUE) AS total_revenue
    FROM {{ ref('stg_transactions') }}
    GROUP BY CUSTOMER_ID, month
),
nrr_grr AS (
    SELECT
        month,
        SUM(CASE WHEN REVENUE_TYPE = 'retained' THEN total_revenue ELSE 0 END) / SUM(total_revenue) AS GRR,
        SUM(CASE WHEN REVENUE_TYPE IN ('retained', 'expanded') THEN total_revenue ELSE 0 END) / SUM(total_revenue) AS NRR
    FROM revenue_analysis
    GROUP BY month
)
SELECT * FROM nrr_grr;