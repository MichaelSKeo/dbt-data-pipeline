WITH customers AS (

    SELECT *
    FROM {{ref('bronze_erp_cust_az12')}} 

)

SELECT 
    CASE 
        WHEN cid LIKE 'NAS%' THEN SUBSTRING(TRIM(cid), 4, LEN(TRIM(cid)))
		ELSE TRIM(cid) 
    END AS cid, 
	CASE 
        WHEN bdate > CURRENT_DATE() THEN NULL 
        ELSE bdate 
    END AS bdate, 
	CASE  
		WHEN UPPER(TRIM(gen)) IS NULL OR UPPER(TRIM(gen)) = ''  THEN 'Unknown'
		WHEN UPPER(TRIM(gen)) = 'M' then 'Male'
		WHEN UPPER(TRIM(gen)) = 'F' then 'Female' 
		ELSE TRIM(gen) 
	END AS gen, 
    NOW() AS dwh_create_date

FROM customers