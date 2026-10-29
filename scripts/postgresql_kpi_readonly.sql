-- Read-only PostgreSQL 16 KPI snapshot; run only on an authorised environment.
-- Review output privately before releasing any values or identifiers.
\set ON_ERROR_STOP on
BEGIN READ ONLY;
SELECT current_setting('server_version') AS postgres_version,
       pg_is_in_recovery() AS is_standby,
       current_setting('archive_mode') AS archive_mode,
       current_setting('wal_level') AS wal_level;
SELECT count(*) AS active_standby_connections FROM pg_stat_replication;
SELECT count(*) AS replication_slots FROM pg_replication_slots;
SELECT count(*) FILTER (WHERE state = 'active') AS active_sessions,
       count(*) FILTER (WHERE state = 'idle in transaction') AS idle_in_transaction_sessions
FROM pg_stat_activity
WHERE backend_type = 'client backend';
SELECT pg_size_pretty(pg_database_size(current_database())) AS current_database_size;
COMMIT;
