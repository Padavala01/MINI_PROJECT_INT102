WITH source AS (
    SELECT DISTINCT
        LOWER(TRIM(company1)) AS company_name,
        company2 as customer_id,
        TRIM(company3) AS customer_name
    FROM {{ source('snowflake_source', 'customers1') }}
    WHERE company1 IS NOT NULL
      AND company2 IS NOT NULL
      AND company3 IS NOT NULL
)
SELECT * FROM source