WITH source AS (

    SELECT * 
    FROM {{ source('dev_crm_erp_database', 'raw_crm_cust_info' )}}  

) 

SELECT 
    CAST(cst_id AS INT) AS cst_id,
    CAST(cst_key AS NVARCHAR(50)) AS cst_key,
    CAST(cst_firstname AS NVARCHAR(50)) AS cst_firstname,
    CAST(cst_lastname AS NVARCHAR(50)) AS cst_lastname,
    CAST(cst_marital_status AS NVARCHAR(50)) AS cst_marital_status,
    CAST(cst_gndr AS NVARCHAR(50)) AS cst_gndr, 
    CAST(cst_create_date AS DATE) AS cst_create_date

FROM source