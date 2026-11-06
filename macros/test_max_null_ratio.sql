{% test max_null_ratio(model, column_name, max_ratio) %}
select null_ratio
from (
    select avg(case when {{ column_name }} is null then 1.0 else 0.0 end) as null_ratio
    from {{ model }}
) as ratios
where null_ratio > {{ max_ratio }}
{% endtest %}
