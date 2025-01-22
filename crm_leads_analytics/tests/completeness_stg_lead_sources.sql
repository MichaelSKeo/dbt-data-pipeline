with source_count as (
    select count(*) as cnt from lead_source_1
),
staging_count as (
    select count(*) as cnt from {{ ref('stg_lead_source_1') }}
)
select
    'stg_lead_source_1' as model,
    source_count.cnt as source_row_count,
    staging_count.cnt as staging_row_count
from source_count, staging_count
where source_count.cnt != staging_count.cnt