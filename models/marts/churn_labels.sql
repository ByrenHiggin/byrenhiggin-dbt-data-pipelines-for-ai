-- One row per customer per month: did they churn (no order) in the following 90 days?
with months as (
    select generate_series(
        date_trunc('month', (select min(ordered_at) from {{ ref('stg_orders') }})),
        date_trunc('month', current_date - interval '90 days'),
        interval '1 month'
    )::date as label_date
),

active as (
    select distinct m.label_date, o.customer_id
    from months as m
    join {{ ref('stg_orders') }} as o
      on o.ordered_at < m.label_date
)

select
    a.customer_id,
    a.label_date,
    not exists (
        select 1
        from {{ ref('stg_orders') }} as o
        where o.customer_id = a.customer_id
          and o.ordered_at >= a.label_date
          and o.ordered_at <  a.label_date + interval '90 days'
    ) as churned
from active as a
