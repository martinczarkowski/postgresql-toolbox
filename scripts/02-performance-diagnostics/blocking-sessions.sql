/*
Purpose:
  Shows currently blocked PostgreSQL sessions and their blockers.

Notes:
  - Read-only.
  - Run while the issue is happening. Blocking is a live-state problem.
  - Requires access to pg_stat_activity details.

Compatibility:
  PostgreSQL 9.6+
*/

SELECT
    blocked_activity.pid AS blocked_pid,
    blocked_activity.usename AS blocked_user,
    blocked_activity.datname AS blocked_database,
    blocked_activity.application_name AS blocked_application,
    blocked_activity.client_addr AS blocked_client_addr,
    blocked_activity.state AS blocked_state,
    blocked_activity.wait_event_type,
    blocked_activity.wait_event,
    age(now(), blocked_activity.query_start) AS blocked_query_age,
    blocked_activity.query AS blocked_query,
    blocking_activity.pid AS blocking_pid,
    blocking_activity.usename AS blocking_user,
    blocking_activity.datname AS blocking_database,
    blocking_activity.application_name AS blocking_application,
    blocking_activity.client_addr AS blocking_client_addr,
    blocking_activity.state AS blocking_state,
    age(now(), blocking_activity.query_start) AS blocking_query_age,
    blocking_activity.query AS blocking_query
FROM pg_stat_activity AS blocked_activity
JOIN pg_stat_activity AS blocking_activity
    ON blocking_activity.pid = ANY(pg_blocking_pids(blocked_activity.pid))
WHERE blocked_activity.pid <> blocking_activity.pid
ORDER BY blocked_query_age DESC;