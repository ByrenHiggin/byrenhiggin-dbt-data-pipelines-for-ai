select
    id::int                         as article_id,
    trim(title)                     as title,
    nullif(trim(body_text), '')     as body_text,
    lower(trim(category))           as category,
    status = 'published'            as is_published,
    updated_at::timestamp           as updated_at
from {{ source('help_centre', 'articles') }}
