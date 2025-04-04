SELECT  
    CAST(cid AS NVARCHAR(50)) AS cid,
	CAST(bdate AS DATE) AS bdate,
	CAST(gen AS NVARCHAR(50)) AS gen

FROM {{ source('dev_crm_erp_database', 'raw_erp_cust_az12') }} 