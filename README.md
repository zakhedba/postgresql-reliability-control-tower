# PostgreSQL Reliability Control Tower — Evidence-led DBA Portfolio

A reproducible, privacy-conscious portfolio documenting PostgreSQL 16 backup and restore assurance for an operational trading application. This repository records observed outcomes, outstanding verification, recovery readiness KPIs, and actionable runbooks. It **does not** contain database dumps, physical backups, WAL, credentials, production endpoints, or raw operational logs.

## Portfolio connections

- [TradeIntel DBA Portfolio] — broader DBA portfolio; source contents should be reviewed before describing individual features.
- [Debug Database Control Tower / KPI Monitoring Dashboard](https://github.com/zakhedba/debug-database-control-tower_KPI_Monitoring_Dashboard/tree/main) — cross-platform control-tower work. SQL Server/Oracle KPI concepts are *referenced*, not misrepresented as PostgreSQL measurements.

## Evidence-backed case studies

| Case | Method | Evidence currently available | Status |
|---|---|---|---|
| [Logical restore: TradeIntel](docs/01-logical-restore.md) | Custom-format dump + `pg_restore` into isolated Docker PostgreSQL 16 | Shell history shows two `pg_restore` invocations, read-only validation queries, `--network none` and resource limits; logs/results to review | **Executed; final result unconfirmed** |
| [Physical backup: PostgreSQL 16](docs/02-physical-backup.md) | `pg_basebackup` + `pg_verifybackup` | Backup creation completed, original verification passed, 2.6 GB backup copied to separate workstation | **Backup verified; restore pending** |

## KPI scorecard

See [KPI register](kpi/KPI_REGISTER.md). **Unmeasured metrics are explicitly N/A / pending**, not zero and not green.

| KPI | Observed status | Evidence needed for a verified pass |
|---|---|---|
| Physical backup completion | PASS on source | Terminal backup completion record |
| Physical backup manifest verification | PASS on source | `pg_verifybackup` pass record |
| Off-host backup copy | COPIED to workstation; destination integrity pending | Destination `pg_verifybackup` pass |
| Logical restore test | COMMANDS EXECUTED, outcome pending | Complete restore log, error status and validation results |
| Physical restore test | NOT PERFORMED | Isolated startup and data checks |
| Recovery time / RTO | NOT MEASURED | Timed successful restore and target RTO |
| Recovery point / RPO | NOT ESTABLISHED | Recovery point, incident assumptions, target RPO |
| PITR readiness | NOT ENABLED at baseline | WAL archiving and PITR recovery demonstration |
| Streaming replication / HA | NOT OBSERVED at baseline | Standby and replication evidence |

## Evidence handling

Only curated non-sensitive summaries belong in `evidence/sanitized/`. Keep original dump, physical basebackup, backup manifests, WAL, raw `docker logs`, SQL results, connection strings and infrastructure identifiers outside this Git repository. A `gitignore` is **not** a substitute for checking staged content.

## Suggested review order

1. Read the two case studies.
2. Compare reported results with [KPI register](kpi/KPI_REGISTER.md).
3. Review [evidence collection checklist](runbooks/EVIDENCE_CHECKLIST.md).
4. Reuse read-only [KPI SQL](scripts/postgresql_kpi_readonly.sql) against an **authorised nonproduction** environment.

## Scope limitations

This documentation is based on session-level terminal output and history provided during October 2026. The existing GitHub repositories and the earlier restore files must be audited before asserting additional outcomes. PostgreSQL backup verification is not proof of a successfully restored and application-validated database.
