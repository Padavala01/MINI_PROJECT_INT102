WITH product_revenue AS (
    SELECT
        p.PRODUCT_ID,
        p.PRODUCT_FAMILY,
        SUM(t.REVENUE) AS total_revenue
    FROM {{ ref('stg_transactions') }} t
    JOIN {{ ref('stg_products') }} p
    ON t.PRODUCT_ID = p.PRODUCT_ID
    GROUP BY p.PRODUCT_ID, p.PRODUCT_FAMILY
)
SELECT
    PRODUCT_ID,
    PRODUCT_FAMILY,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM product_revenue