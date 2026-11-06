{% set as_of = var('as_of_date', run_started_at.strftime('%Y-%m-%d')) %}

with orders as (
    select *
    from {{ ref('stg_orders') }}
    where ordered_at::date <= '{{ as_of }}'::date
)

select
    c.customer_id,
    count(o.order_id)                                     as order_count,
    coalesce(sum(o.total_aud), 0)                         as lifetime_value_aud,
    '{{ as_of }}'::date - max(o.ordered_at)::date         as days_since_last_order,
    coalesce('{{ as_of }}'::date - max(o.ordered_at)::date > 180, true)
                                                          as is_churned
from {{ ref('stg_customers') }} as c
left join orders as o using (customer_id)
group by c.customer_id
