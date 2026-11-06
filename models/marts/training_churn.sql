select
    l.customer_id,
    l.label_date,
    l.churned,
    s.plan,
    s.status_code
from {{ ref('churn_labels') }} as l
join {{ ref('customers_snapshot') }} as s
  on s.customer_id = l.customer_id
 and l.label_date >= s.dbt_valid_from
 and l.label_date <  coalesce(s.dbt_valid_to, 'infinity'::timestamp)
