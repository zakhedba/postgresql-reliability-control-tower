# Evidence review and safe export checklist

## Docker Dallas: inspect existing logical restore lab (read-only)

```bash
find /srv/tradeintel-restore/evidence -maxdepth 2 -type f -printf '%f (%s bytes)\n'
docker inspect tradeintel-pg-restore-lab --format 'ExitCode={{.State.ExitCode}} FinishedAt={{.State.FinishedAt}}'
du -sh /srv/tradeintel-restore/pgdata
```

Do not assume container exit code proves `pg_restore` succeeded. Review raw logs *privately* to establish command exit codes, expected schemas, sample counts and elapsed time. Do not publish query outputs containing trading data.

## Source physical backup

Privately retain the original terminal report proving source-side `pg_verifybackup` success. Summarize only the outcome and version for GitHub.

## Sanitise before staging

Remove real IPs, domains, filesystem usernames, credentials, tokens, database records, client/role names, identifying timestamps if sensitive, and any internal infrastructure details. A public case study should not require a real database backup to be reproducible: provide scripts and **synthetic examples**.

## Dry run before push

```bash
git status --short
git diff --cached --name-only
git diff --cached --check
```

Review staged text manually and run an appropriate secret scanner if available. Keep raw artifacts OUTSIDE the working tree.
