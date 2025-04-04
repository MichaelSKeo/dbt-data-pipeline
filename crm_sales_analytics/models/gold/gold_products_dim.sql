SELECT 
		ROW_NUMBER() OVER (ORDER BY prd. prd_start_dt, prd. prd_id) AS product_key, 
		prd. prd_id AS product_id,
		prd. prd_key AS product_number, 
		prd. prd_nm AS product_name, 
		prd. cat_id AS category_id, 
		cat. cat AS category, 
		cat. subcat AS subcategory, 	
		prd. prd_line AS product_line,
		cat. maintenance, 
		prd. prd_cost AS cost,
		prd. prd_start_dt AS start_date
	
FROM {{ref('silver_crm_prd_info')}}  prd
LEFT JOIN {{ref('silver_erp_px_cat_g1v2')}}  cat
ON        prd. cat_id = cat. id
WHERE prd. prd_end_dt IS NULL