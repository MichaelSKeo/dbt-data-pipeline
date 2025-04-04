WITH category AS (

    SELECT * FROM {{ref('bronze_erp_px_cat_g1v2')}}

) 

SELECT 
	id,
	cat,
	subcat, 
	maintenance, 
    NOW() AS dwh_create_date
		
FROM category 