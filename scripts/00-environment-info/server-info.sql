/*
Purpose:
  Shows PostgreSQL server metadata and selected server-level settings.

Notes:
  - Read-only.
  - Useful as a first snapshot before troubleshooting, migration or deployment work.
  - Some settings may differ depending on permissions and hosting environment.

Compatibility:
  PostgreSQL 9.6+
*/

SELECT
    version() AS full_version_string,
    current_setting('server_version') AS server_version,
    current_setting('server_version_num') AS server_version_num,
    current_setting('TimeZone') AS time_zone,
    current_setting('lc_collate') AS lc_collate,
    current_setting('lc_ctype') AS lc_ctype,
    now() AS collected_at;

SELECT
    name,
    setting,
    unit,
    category,
    short_desc,
    source
FROM pg_settings
WHERE name IN
(
    'max_connections',
    'shared_buffers',
    'work_mem',
    'maintenance_work_mem',
    'effective_cache_size',
    'random_page_cost',
    'seq_page_cost',
    'default_statistics_target',
    'log_min_duration_statement',
    'autovacuum',
    'track_activities',
    'track_counts'
)
ORDER BY name;