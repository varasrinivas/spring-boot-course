# M16 Plan — Database Migrations

**Track:** Data Access with JPA (key: jpa, color: #f59e0b) — LAST of Track 4
**Level:** Intermediate
**Status:** ✅ BUILT

## Concepts
1. Why Migrations (ddl-auto isn't enough) — visual `m16-why-migrations`
2. Flyway: Versioned Migrations — visual `m16-flyway-flow` (files → startup → history table)
3. Writing Migrations (Versioned vs Repeatable) — visual `m16-migration-types`
4. Migrations + JPA validate — visual `m16-validate` (Flyway owns schema, Hibernate validates)

## Coming From Java
Manual SQL run by hand per env, no record of what's applied, drift, fear of prod changes.
Flyway: versioned, automatic, tracked, reproducible.

## Code
- flyway dependency
- V1__create_prior_auth.sql + V2__add_priority.sql + R__view
- ddl-auto=validate + flyway yaml

## SVG
- why-migrations 640×250, flyway-flow 640×270, migration-types 640×250, validate 640×240
