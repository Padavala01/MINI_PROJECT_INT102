
  
    

        create or replace transient table DATA_DB.MINI_PROJECT_DATA_MINI_PROJECT_MART_DATA.revenue_lost_contraction_overtime
         as
        (WITH revenue_contraction AS (
    SELECT
        CUSTOMER_ID,
        DATE_TRUNC('month', TO_DATE(PAYMENT_MONTH)) AS current_month,
        SUM(REVENUE) AS total_revenue
    FROM DATA_DB.MINI_PROJECT_DATA_MINI_PROJECT_STAGED_DATA.stg_transactions
    GROUP BY CUSTOMER_ID, current_month
),

revenue_lost AS (
    SELECT
        current_month,
        SUM(CASE WHEN revenue_change < 0 THEN ABS(revenue_change) ELSE 0 END) AS revenue_lost
    FROM (
        SELECT
            CUSTOMER_ID,
            current_month,
            total_revenue - LAG(total_revenue) OVER (PARTITION BY CUSTOMER_ID ORDER BY current_month) AS revenue_change
        FROM revenue_contraction
    ) t
    GROUP BY current_month
)
SELECT * FROM revenue_contraction
        );
      
  