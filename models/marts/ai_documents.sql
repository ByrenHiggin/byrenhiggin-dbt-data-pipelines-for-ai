select
    'article-' || a.article_id                  as document_id,
    a.title,
    a.body_text                                 as content,
    a.category,
    a.updated_at,
    md5(a.title || coalesce(a.body_text, ''))   as content_hash
from {{ ref('stg_help_articles') }} as a
where a.is_published
  and length(a.body_text) > 200
