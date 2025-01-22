with delta as (
    select * from {{ ref('fct_delta_leads') }}
),
load_timestamp as (
    select
        *,
        now() as loaded_at
    from delta
)
select * from load_timestamp