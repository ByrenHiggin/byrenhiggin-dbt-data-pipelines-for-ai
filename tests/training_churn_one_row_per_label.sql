select customer_id, label_date, count(*) as row_count
from {{ ref('training_churn') }}
group by customer_id, label_date
having count(*) > 1
