# PostgreSQL Toolbox

A collection of practical PostgreSQL and PL/pgSQL scripts, checklists and patterns for database-heavy backend development.

This repository focuses on real-world database work:

- database health checks
- PL/pgSQL function patterns
- performance troubleshooting
- migration safety
- indexing and table size overview
- backend/database integration

The goal is not to provide magic scripts.  
The goal is to make investigation, maintenance and database development safer and more repeatable.

## Contents

- `scripts/00-environment-info` - PostgreSQL and database metadata
- `scripts/01-health-checks` - table sizes, indexes, constraints and schema overview
- `scripts/02-performance-diagnostics` - blocking sessions and long-running transactions
- `scripts/03-plpgsql-patterns` - reusable PL/pgSQL templates
- `docs` - migration and function review checklists

## Notes

This repository contains generic examples and templates only.  
No customer-specific or company-internal code is included.

## Disclaimer

Use these scripts carefully.  
Read them before running them.  
Production databases do not forgive copy-paste heroism.