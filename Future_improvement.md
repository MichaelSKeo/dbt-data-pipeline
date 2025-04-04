## Future improvement: 

Data Model: 
1. Add 'loaded_at' column to raw_data tables

ALTER TABLE raw_erp_cust_az12
ADD COLUMN loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

2. Add refreshness to test schema.yml: 

sources:
  - name: dev_crm_erp_database
    description: "CRM ERP data stored in DuckDB"
    schema: main
    tables:
      - name: raw_crm_cust_info
        description: "Data imported from CSV"
        freshness:
          warn_after: {count: 12, period: hour}
          error_after: {count: 24, period: hour}
        loaded_at_field: "loaded_at"  # Use the column if added in DuckDB

Command: dbt source freshness --select source:dev_crm_erp_database.raw_crm_cust_info

3. Implement incremental load = Upsert strategy to browze layer table to avoid extra cost: (apply on fact tables)

{{ 
  config( materialized='incremental',
          unique_key = 'Order_Id') # this will update existing record if exist, if id not exist, inserted
}}


Main data model code 

{% if is_incremental() %}
WHERE loaded_at >= (select max(dbt_loaded_at)) from {{ this }}
{% endif %}}

4. Add Snapshot table for customer_dim: 

- create a .sql file in snapshot folder: customer_history.sql 
- Configure target schema: 

{% snapshot customers_history %}

{{
  config(
    target_schema='13_consumptin',
    unique_key= 'CUSTOMERID',
    strategy='timestamp', 
    updated_at='updated_at',
    invalidate_hard_deletes=True ## dbt will capture the hard delete and set to current time stampe in the current tab

    ## Use the check straregy below if not updated_date in your source table
    strategy='check',
    check_cols=['phone_no', 'email_id']

  )
}}

SELECT * FROM {{ source('landding' 'customers') }}

{% endshapshot %}

- command: dbt snapshot





