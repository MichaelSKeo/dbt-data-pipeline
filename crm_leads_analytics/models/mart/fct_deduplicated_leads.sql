with unified as (

    select * from {{ ref('int_unified_source_leads') }}

),

deduplicated as (

    select
        *,
        row_number() over (
            partition by phone, address1 
            order by certificate_expiration_date desc, license_issued_date desc
        ) as row_num
    
    from unified

)
select *
from deduplicated
where row_num = 1 -- Keep only the latest record per phone/address1