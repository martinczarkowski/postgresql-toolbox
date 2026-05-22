/*
Purpose:
  Shows currently active long-running transactions.

Notes:
  - Read-only.
  - Long-running transactions can hold locks, prevent vacuum cleanup and cause bloat.
  - Review before terminating anything. The oldest transaction is not always the villain, but it is suspicious.

Compatibility:
  PostgreSQL 9.6+
*/

SELECT
    pid,
    usename AS user_name,
    datname AS database_name,
    application_name,
    client_addr,
    state,
    backend_start,
    xact_start,
    query_start,
    age(now(), xact_start) AS transaction_age,
    age(now(), query_start) AS query_age,
    wait_event_type,
    wait_event,
    query
FROM pg_stat_activity
WHERE xact_start IS NOT NULL
  AND pid <> pg_backend_pid()
ORDER BY xact_start ASC;