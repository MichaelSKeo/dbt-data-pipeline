SELECT 
		s. sls_ord_num AS order_number, 
		p. product_key,
		c. customer_key,  
		s. sls_order_dt AS order_date, 
		s. sls_ship_dt AS shipping_date, 
		s. sls_due_dt AS due_date,
		s. sls_sales AS sales_amount, 
		s. sls_quantity AS quantity, 
		s. sls_price AS price
		
FROM {{ref('silver_crm_sales_details')}}  s
LEFT JOIN {{ref('gold_products_dim')}}  p
ON        s. sls_prd_key = p. product_number
LEFT JOIN {{ref('gold_customers_dim')}}  c
ON		  s. sls_cust_id = c. customer_id