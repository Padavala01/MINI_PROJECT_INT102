--cross chun
WITH total_quantities AS (
    SELECT 
        customer_id,
        TO_DATE(payment_month) AS date1,
        SUM(quantity) AS quantity,
    FROM DATA_DB.MINI_PROJECT_DATA_MINI_PROJECT_STAGED_DATA.stg_transactions
    GROUP BY customer_id, TO_DATE(payment_month)
    ORDER BY date1
),
first_value as (
SELECT 
    DISTINCT customer_id,
    FIRST_VALUE(quantity) OVER (PARTITION BY customer_id ORDER BY date1) AS first_quantity
FROM total_quantities
ORDER BY customer_id
)
,
result AS
 (
    SELECT 
        customer_id,
        sum(quantity) AS quantity 
    FROM total_quantities GROUP BY customer_id)

SELECT 
    top 1
    first_value.customer_id,
    quantity-first_quantity AS cross_chunk 
FROM result INNER JOIN first_value
ON result.customer_id=first_value.customer_id order by cross_chunk desc

--cross chun end