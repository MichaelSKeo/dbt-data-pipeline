WITH source AS (

    SELECT * 
    FROM {{ source('dev_crm_erp_database', 'raw_crm_prd_info')}} 

) 

SELECT 
    CAST(prd_id AS INT) AS prd_id,
    CAST(prd_key AS NVARCHAR(50)) AS prd_key,
    CAST(prd_nm AS NVARCHAR(50)) AS prd_nm, 
    CAST(prd_cost AS INT) AS prd_cost,
    CAST(prd_line AS NVARCHAR(50)) AS prd_line,
    CAST(prd_start_dt AS DATE) AS prd_start_dt,
    CAST(prd_end_dt AS DATE) AS prd_end_dt

FROM source
