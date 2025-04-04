WITH source AS (

    SELECT * 
    FROM {{ source('dev_crm_erp_database', 'raw_crm_sales_details') }} 

) 

SELECT 
    CAST(sls_ord_num AS NVARCHAR(50)) AS sls_ord_num,
    CAST(sls_prd_key AS NVARCHAR(50)) AS sls_prd_key,
    CAST(sls_cust_id AS NVARCHAR(50)) AS sls_cust_id,
    CAST(sls_order_dt AS INT) AS sls_order_dt,
    CAST(sls_ship_dt AS INT) AS sls_ship_dt,
    CAST(sls_due_dt AS INT) AS sls_due_dt,
    CAST(sls_sales AS DECIMAL(20,2)) AS sls_sales, 
    CAST(sls_sales AS INT) AS sls_quantity, 
    CAST(sls_price AS DECIMAL(20,2)) AS sls_price

FROM source