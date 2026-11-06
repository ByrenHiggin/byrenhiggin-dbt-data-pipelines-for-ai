select
    order_no::int                   as order_id,
    cust_no::int                    as customer_id,
    order_dt::timestamp             as ordered_at,
    total_amt::numeric(12, 2)       as total_aud
from {{ source('legacy_crm', 'orders') }}
where order_no is not null
