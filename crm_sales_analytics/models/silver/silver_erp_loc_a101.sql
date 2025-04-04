WITH locations AS (

    SELECT * FROM {{ref('bronze_erp_loc_a101')}}

)

SELECT 

	REPLACE(TRIM(cid),'-', '') AS cid, 
	CASE 
		WHEN UPPER(TRIM(cntry)) IS NULL OR UPPER(TRIM(cntry)) = '' THEN 'n/a'
		when UPPER(TRIM(cntry)) IN ('USA', 'US') THEN 'United States' 
		when UPPER(TRIM(cntry)) = 'DE' THEN 'Germany'
		ELSE TRIM(cntry)
	END cntry, 
	NOW() AS dwh_create_date

FROM locations 