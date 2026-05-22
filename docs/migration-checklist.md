# PostgreSQL Migration Checklist

A practical checklist for PostgreSQL database changes.

## Before migration

- Confirm target PostgreSQL version.
- Confirm database owner and permissions.
- Confirm latest backup exists and can be restored.
- Review migration script manually.
- Check whether the migration is safe to run more than once.
- Check whether the migration modifies large tables.
- Check whether the migration requires downtime.
- Check available disk space.
- Check long-running transactions.
- Check active blocking.

## Schema changes

Look carefully for:

- dropped tables
- dropped columns
- renamed columns
- type changes
- nullability changes
- new unique constraints
- new foreign keys
- large index creation
- table rewrites

## Data changes

- Is existing data preserved?
- Is data backfill needed?
- Should data updates be batched?
- Can the migration be resumed safely?
- Can the migration be rolled back?
- Is rollback safe for production data?

## After migration

- Verify expected schema objects exist.
- Verify row counts where relevant.
- Verify constraints.
- Run smoke-test queries.
- Check application startup.
- Check logs.
- Keep migration output with release notes.

## Notes

Migrations are not just scripts.  
They are production events with consequences.