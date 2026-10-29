# Case study 02 — PostgreSQL 16 physical backup and verification

**Evidence date:** 29 October 2026.

## Objective
Establish a physical backup baseline, verify the manifest and begin a portable off-host recovery exercise for PostgreSQL 16.

## Observed results

- PostgreSQL 16.15 primary cluster observed online on the source VM.
- `pg_basebackup` completed with progress `2682492/2682492 kB (100%), 1/1 tablespace`.
- `pg_verifybackup` on the source returned `backup successfully verified`.
- Backup occupied approximately **2.6 GB**.
- Backup was copied to a separate Debian 13 workstation, and both `PG_VERSION` (16) and a `backup_manifest` were observed.
- Destination `pg_verifybackup` has **not** yet been successfully run; the first attempt on a different Docker host failed due to an absent backup mount.

## Known recovery gaps at assessment

- No confirmed PITR-ready WAL archiving (`archive_mode=off` at baseline).
- No confirmed active streaming standby or replication slot at baseline.
- No demonstrated isolated physical-cluster restart yet.
- No objective RTO/RPO or automated offsite rotation demonstrated.
- A source-local copy and a workstation copy do not by themselves establish retention policy, immutability or offsite resilience.

## Next safe checkpoint
Verify the workstation copy using PostgreSQL 16 tools, preferably in a container running on **the workstation where the copy resides**, and perform a later isolated physical restore with independent resources and safe configuration. Do not ship a second full backup to an application-serving Docker host solely to produce GitHub evidence.

## What NOT to publish
Data files, WAL, backup manifest, configuration secrets, source IP addresses, hostnames, credentials, full process listings or raw logs.
