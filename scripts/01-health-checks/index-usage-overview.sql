/*
Purpose:
  Shows basic index usage statistics for user tables.

Notes:
  - Read-only.
  - Statistics are cumulative since the last statistics reset.
  - Low usage does not automatically mean an index is useless. Always verify workload and constraints.

Compatibility:
  PostgreSQL 9.6+
*/

SELECT
    schemaname AS schema_name,
    relname AS table_name,
    indexrelname AS index_name,
    idx_scan AS index_scans,
    idx_tup_read AS index_tuples_read,
    idx_tup_fetch AS index_tuples_fetched,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size,
    pg_relation_size(indexrelid) AS index_size_bytes
FROM pg_stat_user_indexes
ORDER BY idx_scan ASC, pg_relation_size(indexrelid) DESC, schemaname, relname, indexrelname;