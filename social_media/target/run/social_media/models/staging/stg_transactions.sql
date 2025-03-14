
  
    

        create or replace transient table DATA_DB.MINI_PROJECT_DATA_MINI_PROJECT_STAGED_DATA.stg_transactions
         as
        (WITH source AS (
    SELECT
        customer_id,
        product_id,
        payment_month,
        revenue_type,
        CAST(revenue AS FLOAT) AS revenue,
        CAST(quantity AS INT) AS quantity,
        dimension1 AS dim_a,
        dimension2 AS dim_b,
        dimension3 AS dim_c,
        dimension4 AS dim_d,
        dimension5 AS dim_e,
        dimension6 AS dim_f,
        dimension7 AS dim_g,
        dimension8 AS dim_h,
        dimension9 AS dim_i,
        dimension10 AS dim_j,
        companies
    FROM DATA_DB.MINI_PROJECT_DATA.transaction1
)
SELECT * FROM source
        );
      
  