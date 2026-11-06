with legacy as (
    select customer_id, order_count, round(lifetime_value, 2) as lifetime_value
    from {{ source('legacy_crm', 'customer_summary') }}
),

rebuilt as (
    select customer_id, order_count, round(lifetime_value_aud, 2) as lifetime_value
    from {{ ref('customer_features') }}
)

(select 'missing from rebuilt' as problem, * from legacy
 except
 select 'missing from rebuilt', * from rebuilt)

union all

(select 'missing from legacy' as problem, * from rebuilt
 except
 select 'missing from legacy', * from legacy)
