with lead_work as (
    select
        id,
        status,
        last_activity_date
    from {{ ref('fct_sfdc_leads') }} -- Assume SFDC leads refresh every hour to capture the new loads
),
metrics as (
    select
        count(case when status = 'Working' and last_activity_date >= current_date - 1 then id end)  as pct_leas_worked_today,  
        count(case when status = 'Working' and last_activity_date >= current_date - 7 then id end)  as pct_leads_worked_last_week, 
        count(*) as total_lead
    from lead_work
)
select * from metrics