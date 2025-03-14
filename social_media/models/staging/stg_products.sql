WITH source AS (
    SELECT
        product_id,
        UPPER(TRIM(PRODUCT_Family)) AS product_family,
        TRIM(product_sub_family) AS product_sub_family
    FROM {{ source('snowflake_source', 'products1') }}
    WHERE product_family IS NOT NULL
      AND product_sub_family IS NOT NULL
      AND product_id IS NOT NULL

)
SELECT * FROM source