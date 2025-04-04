WITH products AS (

    SELECT * 
    FROM {{ref('bronze_crm_prd_info')}} 

) 

SELECT
    prd_id,
    TRIM(REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_')) AS cat_id, 
	TRIM(SUBSTRING(prd_key, 7, LEN(prd_key))) AS prd_key,  
	prd_nm, 
	CASE WHEN prd_cost IS NULL THEN 0 ELSE prd_cost END AS prd_cost, 
	CASE UPPER(TRIM(prd_line))
		WHEN 'S' then 'Other Sales'
		WHEN 'T' then 'Touring'
		WHEN 'M' then 'Mountain'
		WHEN 'R' then 'Road'
		ELSE 'Unknown' 
	END AS prd_line,
	CAST(prd_start_dt AS date) AS prd_start_dt, 
	-- CAST(DATEADD(day, -1, lead(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)) as date) as prd_end_dt 
    LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 as prd_end_dt, 
    NOW() AS dwh_create_date

FROM products