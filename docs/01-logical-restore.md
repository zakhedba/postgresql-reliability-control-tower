# Case study 01 — TradeIntel logical backup and Docker restore exercise

**Evidence date:** 19 October 2026 (based on timestamp in dump filename and reported container creation age; verify actual execution timestamp against original records).

## Objective
Demonstrate restoration of a custom-format PostgreSQL logical dump into an isolated PostgreSQL 16 container and collect success criteria without exposing trading data.

## Observed execution
The operator's shell history shows:

- Inspection of a custom-format dump using `pg_restore --list` and identification of extensions, functions, triggers and related objects.
- Creation of a restore selection list.
- Launch of a Docker PostgreSQL 16 container named `tradeintel-pg-restore-lab` with `--network none`, a 768 MB memory limit, one CPU, a persistent data directory and read-only backup/evidence mounts.
- `pg_isready` readiness checks.
- A `pg_restore` invocation into a first database with `--no-owner --no-acl --exit-on-error --jobs=1 --use-list=...`.
- Creation of a second test database and a second `pg_restore` invocation with verbose output.
- Multiple SQL validation commands.
- The restore container was later seen stopped with status `Exited (0)`; this reflects the container process exit, **not** the restore command's exit status.

## Status and proof standard
**Commands executed. Successful database restoration is NOT YET VERIFIED from the available logs.** Review original restore output and capture:

1. Shell exit status or complete `pg_restore` log with zero errors.
2. A post-restore SQL connectivity check.
3. Schema/object counts and a non-sensitive set of validation results compared with an authorised expected baseline.
4. Timed restore duration if a reliable elapsed-time record exists.
5. Any exclusions in `restore.list` and their implications for functional completeness.

## Security and methodology
- Docker network disabled during logical restore. No published database ports in recorded command.
- `POSTGRES_HOST_AUTH_METHOD=trust` was used for an isolated lab; never reuse this setting for network-connected or production systems.
- `--no-owner --no-acl` changes ownership/privileges relative to the source; the restore is not a production-ready identity/permissions recovery test.
- `--use-list` may filter objects; review the list before declaring the restore fully equivalent to production.
- The exercise is a **logical restore**, not a physical cluster/PITR test.

## Original evidence location (private)
TradeIntel recovery lab under `/srv/tradeintel-restore/` on the Docker server. No raw files from this directory should be pushed to a public repository without individual review and sanitisation.
