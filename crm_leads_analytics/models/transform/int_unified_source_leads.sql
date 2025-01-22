with source_1 as (
    select * from {{ ref('stg_lead_source_1') }}
),


source_2 as (
    select * from {{ ref('stg_lead_source_2') }}
),


source_3 as (
    select * from {{ ref('stg_lead_source_3') }}
),

combined as (
    select 
        company, 
        null as accepts_financial_aid, 
        null as ages_served, 
        null as capacity, 
        license_type, 
        license_status,
        license_issued_date,
        certificate_expiration_date, 
        address1, 
        address2, 
        state, 
        county, 
        zip, 
        phone,
        first_name, 
        last_name, 
        title,
        null as email,  
        null as schedule, 
        null as webstie_address, 
        null as facility_type,
        'Source 1' as lead_source

    from source_1 

    union all

    select 
        company, 
        accepts_financial_aid, 
        ages_served, 
        capacity, 
        license_type, 
        license_status,
        license_issued_date,
        null as certificate_expiration_date, 
        address1, 
        address2, 
        state, 
        null as county, 
        zip, 
        phone,
        first_name, 
        last_name, 
        title,
        email,  
        null as schedule, 
        null as webstie_address, 
        null as facility_type,
        'Source 2' as lead_source

    from source_2 

    union all 

    select 
        company, 
        null as accepts_financial_aid, 
        ages_served, 
        capacity, 
        license_type, 
        license_status,
        license_issued_date,
        null as certificate_expiration_date, 
        address1, 
        address2, 
        state, 
        county, 
        zip, 
        phone,
        null as first_name, 
        null as last_name, 
        null as title,
        email,  
        null as schedule, 
        null as webstie_address, 
        null as facility_type,
        'Source 3' as lead_source

    from source_3 

) 

, final as (

    select 
        *,
        case 
            when ages_served ilike '%infant%' then 0 
            when ages_served ilike '%toddler%' then 12
            when ages_served ilike '%reschool%' then 24
            when ages_served ilike '%school%' then 60
        end as min_age,  

        case 
            when ages_served ilike '%school%' then 60
            when ages_served ilike '%reschool%' then 24
            when ages_served ilike '%toddler%' then 12
            when ages_served ilike '%infant%' then 0 
        end as max_age,  

    from combined 

)

select * from final 
