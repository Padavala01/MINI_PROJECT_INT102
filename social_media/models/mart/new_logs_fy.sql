WITH new_logos AS (
    SELECT
        CUSTOMER_ID,
        DATE_TRUNC('year', TRY_TO_DATE(min(PAYMENT_MONTH), 'YYYY-MM-DD HH24:MI:SS.FF')) AS fiscal_year
    FROM {{ ref('stg_transactions') }}
    WHERE TRY_TO_DATE(PAYMENT_MONTH) IS NOT NULL
    GROUP BY CUSTOMER_ID
)
SELECT fiscal_year, COUNT(DISTINCT CUSTOMER_ID) AS new_logos
FROM new_logos
GROUP BY fiscal_year