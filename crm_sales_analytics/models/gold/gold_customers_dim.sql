SELECT 
		ROW_NUMBER() OVER (ORDER BY cus. cst_id) AS customer_key,
		cus. cst_id AS customer_id,
		cus. cst_firstname AS first_name, 
		cus. cst_lastname AS last_name,
		CASE  
			WHEN cus. cst_gndr in ('Male', 'Female') THEN cst_gndr
			WHEN cus. cst_gndr = 'Unknown' and erc. gen in ('Male', 'Female') THEN COALESCE(erc. gen, cst_gndr)
			ELSE 'Unknown'
		END AS gender,  
		cus. cst_marital_status AS marital_status, 
		erl. cntry AS country, 
		erc. bdate AS birth_date, 
		cus. cst_create_date AS create_date

FROM {{ref('silver_crm_cust_info')}} cus
LEFT JOIN {{ref('silver_erp_cust_az12')}} erc 
ON		  cus. cst_key = erc. cid
LEFT JOIN {{ref('silver_erp_loc_a101')}} erl 
ON		  cus. cst_key = erl. cid 