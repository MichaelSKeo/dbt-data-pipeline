with source_3 as (
    select
        operation_name as company,
        agency_number,
        address as address1,
        null as address2,
        city,
        state,
        zip,
        county,
        REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(phone)), '-', ''), '(', ''), ')', '') AS phone, 
        capacity,
        email_address as email,
        facility_id,
        infant,
        toddler,
        preschool,
        school, 
        type as license_type, 
        status as license_status, 
        cast(issue_date as date) as license_issued_date,
        infant,
        toddler,
        preschool,
        school,
        case when infant = 'Y' then 'Infant (0 - 11 months)' end as infant_age, 
        case when toddler = 'Y' then 'Toddler (12 - 23 months)' end as toddler_age, 
        case when preschool = 'Y' then 'Preschool (24 - 48 months)' end as preschool_age, 
        case when school = 'Y' then 'School (5 years)' end as school_age, 
        concat(infant_age, ', ', toddler_age, ', ', preschool_age, ', ', school_age) as ages_served 

    from lead_source_3
)

select * from source_3