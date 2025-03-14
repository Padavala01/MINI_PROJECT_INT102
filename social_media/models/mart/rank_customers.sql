WITH customer_revenue AS (
    SELECT
        CUSTOMER_ID,
        SUM(REVENUE) AS total_revenue
    FROM {{ ref('stg_transactions') }}
    GROUP BY CUSTOMER_ID
)
SELECT
    CUSTOMER_ID,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM customer_revenue