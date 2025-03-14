
  
    

        create or replace transient table DATA_DB.MINI_PROJECT_DATA_MINI_PROJECT_MART_DATA.new_logs_fy
         as
        (WITH new_logos AS (
    SELECT
        CUSTOMER_ID,
        DATE_TRUNC('year', TRY_TO_DATE(min(PAYMENT_MONTH), 'YYYY-MM-DD HH24:MI:SS.FF')) AS fiscal_year
    FROM DATA_DB.MINI_PROJECT_DATA_MINI_PROJECT_STAGED_DATA.stg_transactions
    WHERE TRY_TO_DATE(PAYMENT_MONTH, 'YYYY-MM-DD HH24:MI:SS.FF') IS NOT NULL
    GROUP BY CUSTOMER_ID
)
SELECT fiscal_year, COUNT(DISTINCT CUSTOMER_ID) AS new_logos
FROM new_logos
GROUP BY fiscal_year
        );
      
  