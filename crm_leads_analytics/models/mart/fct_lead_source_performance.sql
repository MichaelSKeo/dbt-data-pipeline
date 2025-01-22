with lead_sources as (
    select
        lead_source,
        count(*) as total_leads,
        count(case when is_converted then id end) as converted_leads
    from {{ ref('fct_sfdc_leads') }}
    group by 1
    
),
performance as (
    select
        lead_source,
        total_leads,
        converted_leads,
        (converted_leads::decimal / total_leads) * 100 as conversion_rate
    from lead_sources
)
select * from performance