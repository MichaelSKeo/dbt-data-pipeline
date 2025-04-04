SELECT * 
FROM {{ref('gold_sales_fact')}} 
WHERE sales_amount != quantity * price 