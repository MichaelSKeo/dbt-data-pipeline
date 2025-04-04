SELECT * 
FROM {{ref('gold_sales_fact')}} 
WHERE order_date < shipping_date or shipping_date < due_date or order_date < due_date