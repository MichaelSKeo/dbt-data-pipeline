with source_1 as (
    select
        name as company,
        credential_type as license_type,
        credential_number,
        status as license_status,
        cast(expiration_date as date) as certificate_expiration_date,
        disciplinary_action,
        REGEXP_REPLACE(address, ',.*', '') as address1, 
        null as address2,
        REGEXP_EXTRACT(address, '([A-Za-z\s]+)', 1) as city, 
        REGEXP_EXTRACT(address, '(\d{5}(-\d{4})?)$', 1) AS zip, 
        state,
        county,
        TRIM(REPLACE(REPLACE(REPLACE(phone, '(', ''), ')', ''), '-', '')) as phone,
        cast(first_issue_date as date) as license_issued_date,
        primary_contact_name,
        
        TRIM(CASE 
            WHEN primary_contact_name LIKE '%&%' THEN SPLIT_PART(primary_contact_name, ' ', 1) -- Handle multi-part names
            ELSE SPLIT_PART(primary_contact_name, ' ', 1) -- First word as first name
        END) AS first_name,
        
        TRIM(CASE 
        WHEN primary_contact_name LIKE '%&%' THEN TRIM(SPLIT_PART(primary_contact_name, '&', 2)) -- Handle "&" in last names
        ELSE SPLIT_PART(primary_contact_name, ' ', 2) -- Last word as last name
        END) AS last_name, 
        
        TRIM(primary_contact_role) as title, 
    
    from lead_source_1

)

select * from source_1