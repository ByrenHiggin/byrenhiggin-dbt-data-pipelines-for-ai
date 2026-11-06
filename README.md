# Migrating, transforming and testing data for AI with dbt

Example dbt project for the article at
https://byrenhigg.in/blog/dbt-data-pipelines-for-ai/

```text
legacy CRM, orders DB, help centre
              │
              ▼
   sources ── raw tables, untouched, freshness checked
              │
   staging ── one model per source table: renamed, typed, cleaned
              │
   snapshots ─ history of records that change, for point-in-time joins
              │
   marts ──── customer_features · training_churn · ai_documents
              │
              ├─▶ model training and scoring
              └─▶ embedding job for search and assistants
```

Written for PostgreSQL and dbt 1.10 or later.

## Running it

Copy `profiles.example.yml` to `~/.dbt/profiles.yml` and fill in your
connection, then:

```bash
dbt source freshness
dbt build
```

In CI, build and test only what changed, deferring to production artifacts:

```bash
dbt build --select state:modified+ --defer --state ./prod-artifacts
```

The raw tables (`raw_crm.customers`, `raw_crm.orders`,
`raw_crm.customer_summary`, `raw_help_centre.articles`) must already be loaded.
dbt does not move data between systems.
