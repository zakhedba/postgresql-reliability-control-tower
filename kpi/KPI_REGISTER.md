# PostgreSQL DBA KPI register

All statuses reflect observed evidence only, as of 29 October 2026. `PASS` indicates an observed test result, not compliance with an unspecified SLA.

| ID | KPI | Definition / formula | Result | Evidence status | Target |
|---|---|---|---|---|---|
| PG-01 | Physical backup completion | Successful `pg_basebackup` exit and full transfer | Completed | Observed | To define |
| PG-02 | Physical backup validation | `pg_verifybackup` exit code zero | PASS on source | Observed | 100% of scheduled backups |
| PG-03 | Remote copy integrity | `pg_verifybackup` on independent location | Pending | Transfer confirmed, integrity test not shown | 100% |
| PG-04 | Logical restore validation | Successful `pg_restore`, consistency checks | Pending audit | Commands observed only | 100% of sampled restores |
| PG-05 | Physical restore validation | Start recovered cluster and inspect data | Not tested | No evidence | Periodic |
| PG-06 | Recovery time actual | End of successful recovery minus start | N/A | Not measured | Define RTO |
| PG-07 | Recovery point actual | Last recoverable transaction time vs failure time | N/A | Not measured | Define RPO |
| PG-08 | PITR readiness | WAL archive coverage and restore validation | Not demonstrated | `archive_mode=off` baseline | Define |
| PG-09 | Replication health | Active standby and replay delay | No standby observed | Read-only baseline | Define |
| PG-10 | Backup scheduling | Scheduled job success over reporting window | Not demonstrated | Timer inactive baseline | Define |
| PG-11 | Storage headroom | Free bytes / total bytes per relevant filesystem | Inspect per host | Partial baseline | Define |
| PG-12 | Blocking / long transactions | Sessions above policy thresholds | Baseline observation only | Historical single idle-in-transaction session | Define |

**Notes:** Do not present SQL Server/Oracle Control Tower metric weights as PostgreSQL operational policy without explicitly defining and validating an independent PostgreSQL score model. Do not infer that zero replication rows means an HA service-level failure if the architecture does not require a standby; record readiness and intended design first.
