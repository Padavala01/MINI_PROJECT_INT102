
  
    

        create or replace transient table DATA_DB.MINI_PROJECT_DATA_MINI_PROJECT_MART_DATA.rank_customers
         as
        (WITH customer_revenue AS (
    SELECT
        CUSTOMER_ID,
        SUM(REVENUE) AS total_revenue
    FROM DATA_DB.MINI_PROJECT_DATA_MINI_PROJECT_STAGED_DATA.stg_transactions
    GROUP BY CUSTOMER_ID
)
SELECT
    CUSTOMER_ID,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM customer_revenue
        );
      
  