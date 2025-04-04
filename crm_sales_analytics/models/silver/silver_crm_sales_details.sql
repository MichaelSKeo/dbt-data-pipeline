WITH sales AS (

    SELECT * 
    FROM {{ref('bronze_crm_sales_details')}}

) 

select 
	sls_ord_num, 
	sls_prd_key, 
	sls_cust_id,
	CAST(STRPTIME(CAST(CASE 
		WHEN sls_order_dt <= 0 OR LEN(CAST(sls_order_dt AS STRING)) != 8 THEN NULL 
		ELSE sls_order_dt 
    END AS VARCHAR), '%Y%M%d') AS DATE) AS sls_order_dt, 
	CAST(STRPTIME(CAST(sls_ship_dt AS VARCHAR), '%Y%M%d') AS DATE) AS sls_ship_dt, 
	CAST(STRPTIME(CAST(sls_due_dt AS VARCHAR), '%Y%M%d') AS DATE) AS sls_due_dt, 
    CASE 
		WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity*ABS(sls_price) THEN sls_quantity * ABS(sls_price) 
		ELSE sls_sales 
    END as sls_sales, 
	sls_quantity, 
	CASE 
		WHEN sls_price IS NULL OR sls_price <= 0
		THEN sls_sales / NULLIF(sls_quantity, 0)
		ELSE sls_price
    END AS sls_price, 
	NOW() AS dwh_create_date

FROM sales