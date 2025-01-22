with source_2 as (
    select
        company as company,
        type_license as license_type,
        accepts_subsidy as accepts_financial_aid,
        star_level as license_status,
        LTRIM(RTRIM(TRIM(REPLACE(REPLACE(REPLACE(phone, '(', ''), ')', ''), '-', '')))) as phone,
        email,
        address1 || ' ' || address2 as address1,
        null as address2,
        city,
        state,
        zip,
        total_cap as capacity,
        subsidy_contract_number,
        primary_caregiver, 
        REGEXP_REPLACE(primary_caregiver, '\n[\s]*\n', ' ', 'g') AS cleaned_name, 
        TRIM(SPLIT_PART(cleaned_name, ' ', 1)) AS first_name, -- Extract the first word as the first name
        TRIM(SPLIT_PART(cleaned_name, ' ', 2)) AS last_name, 
        TRIM(REGEXP_REPLACE(cleaned_name, '^(\S+\s+\S+\s+)', '')) AS title, 
        cast(right(license_monitoring_since, 10) as date) AS license_issued_date, 
        concat(ages_accepted_1, ', ', AA2, ', ', AA3, ', ', AA4) as ages_served, 
        Replace(Replace(AA2,'1yr.', ''), '2-4 yrs.', '') as AA2 , 
        replace(replace(AA3,  '2-4 yrs.', ''), '5 years-older', '60 monhts') as AA3, 
        replace(AA4, '5 years-older', '60 monhts') as aa4   

    from lead_source_2
)

select * from source_2