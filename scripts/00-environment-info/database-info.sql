/*
Purpose:
  Shows metadata for the current PostgreSQL database.

Notes:
  - Read-only.
  - Run this script in the database you want to inspect.
  - Useful before deployments, migrations and performance troubleshooting.

Compatibility:
  PostgreSQL 9.6+
*/

SELECT
    d.datname AS database_name,
    pg_catalog.pg_get_userbyid(d.datdba) AS owner_name,
    pg_database_size(d.datname) AS database_size_bytes,
    pg_size_pretty(pg_database_size(d.datname)) AS database_size,
    d.encoding,
    d.datcollate,
    d.datctype,
    d.datistemplate,
    d.datallowconn,
    d.datconnlimit
FROM pg_database AS d
WHERE d.datname = current_database();

SELECT
    n.nspname AS schema_name,
    COUNT(c.oid) FILTER (WHERE c.relkind = 'r') AS table_count,
    COUNT(c.oid) FILTER (WHERE c.relkind = 'v') AS view_count,
    COUNT(c.oid) FILTER (WHERE c.relkind = 'm') AS materialized_view_count,
    COUNT(c.oid) FILTER (WHERE c.relkind = 'S') AS sequence_count
FROM pg_namespace AS n
LEFT JOIN pg_class AS c
    ON c.relnamespace = n.oid
WHERE n.nspname NOT IN ('pg_catalog', 'information_schema')
  AND n.nspname NOT LIKE 'pg_toast%'
GROUP BY n.nspname
ORDER BY n.nspname;

SELECT
    current_database() AS database_name,
    current_user AS current_user_name,
    session_user AS session_user_name,
    inet_server_addr() AS server_address,
    inet_server_port() AS server_port;