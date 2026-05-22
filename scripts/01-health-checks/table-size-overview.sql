/*
Purpose:
  Shows row estimates and size information for user tables in the current database.

Notes:
  - Read-only.
  - Row counts are estimates from PostgreSQL statistics.
  - Run ANALYZE for more accurate planner statistics.

Compatibility:
  PostgreSQL 9.6+
*/

SELECT
    schemaname AS schema_name,
    relname AS table_name,
    n_live_tup AS estimated_live_rows,
    n_dead_tup AS estimated_dead_rows,
    pg_size_pretty(pg_total_relation_size(relid)) AS total_size,
    pg_size_pretty(pg_relation_size(relid)) AS table_size,
    pg_size_pretty(pg_indexes_size(relid)) AS indexes_size,
    pg_total_relation_size(relid) AS total_size_bytes,
    last_vacuum,
    last_autovacuum,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
ORDER BY pg_total_relation_size(relid) DESC, n_live_tup DESC;