with current_load as (
    select * from {{ ref('fct_deduplicated_leads') }}
)

, previous_load as (
    select * from {{ ref('fct_sfdc_leads') }} -- Assume a table storing previous loads
),

delta as (
    select
        current.first_name,
        current.last_name,
        current.title,
        current.company,
        current.lead_source, 
        current.phone,
        current.email,
        current.address1,
        current.address2,
        current.capacity,
        previous.capacity_c as prev_capacity, 
        case
            when previous.phone is null then 'New Lead'
            when current.capacity != previous.capacity_c then 'Updated Lead'
            else 'No Change'
        end as change_type -- need to define and align with business stakeholders' definitions 
    from current_load current
    left join previous_load previous
        on current.phone = cast(previous.phone as text)
        and current.address1 = previous.street
)
select * from delta