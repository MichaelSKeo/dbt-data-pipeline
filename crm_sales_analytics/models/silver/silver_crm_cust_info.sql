WITH customers AS ( 

    SELECT *
    , ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS rn 
    FROM {{ref('bronze_crm_cust_info')}} 
    WHERE cst_id IS NOT NULL 

)

SELECT
 cst_id, 
    cst_key, 
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,
    CASE UPPER(TRIM(cst_marital_status))
        WHEN 'M' THEN 'Married'
        WHEN 'S' THEN 'Single'
        ELSE 'n/a'
    END AS cst_marital_status, 
    CASE UPPER(TRIM(cst_gndr))
        WHEN 'M' THEN 'Male'
        WHEN 'F' THEN 'Female'
        ELSE 'n/a'
    END AS cst_gndr,
    cst_create_date, 
    NOW() AS dwh_create_date

FROM customers
WHERE rn = 1