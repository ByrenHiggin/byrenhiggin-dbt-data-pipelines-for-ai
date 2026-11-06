select
    cust_no::int                    as customer_id,
    lower(trim(email_addr))         as email,
    nullif(trim(status_cd), '')     as status_code,
    nullif(trim(plan_cd), '')       as plan,
    created_dt::timestamp           as created_at,
    last_mod_dt::timestamp          as updated_at
from {{ source('legacy_crm', 'customers') }}
where cust_no is not null
