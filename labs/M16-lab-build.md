# M16 Lab — Build It with AI Path

> **Module:** M16 · Database Migrations
> **Track:** Data Access with JPA
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Put the Prior Authorization Service's schema under Flyway: baseline migration, an additive
change, a repeatable view, and `ddl-auto: validate` — proving the schema is reproducible.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: Baseline Migration (15 min)

Ask Claude Code:

> "Add `flyway-core`. Create `src/main/resources/db/migration/V1__create_prior_auth.sql` and a
> `V1.1__create_audit_entry.sql` matching the current entities. Switch
> `spring.jpa.hibernate.ddl-auto` to `validate`. Start the app and show me the
> `flyway_schema_history` rows."

**Review:** Do the migration columns exactly match the entities? Did the app start with
`validate` (proving they agree)?

---

## Step 2: An Additive Change (15 min)

> "Add a `priority` field (`ROUTINE`/`URGENT`) to the `PriorAuth` entity AND a
> `V2__add_priority.sql` migration with a sensible default. Restart and confirm Flyway applied
> only V2 and validation still passes."

**Your judgment call:** Try editing V1 instead of adding V2 — observe Flyway's checksum error on
startup, then revert. Why does it refuse?

---

## Step 3: A Repeatable View (10 min)

> "Add `R__pending_by_cpt.sql` creating a `pending_by_cpt` view, and a read-only endpoint backed
> by it. Then change the view's grouping and restart — show that Flyway re-applied R because its
> checksum changed."

```powershell
curl http://localhost:8080/api/prior-auths/reports/pending-by-cpt
```

---

## Step 4: Reflect (10 min)

- [ ] What changed about your confidence deploying a schema change vs hand-run SQL?
- [ ] Why is `validate` safer than `update` in CI and prod?
- [ ] How would you run these migrations against a real PostgreSQL in tests (preview of Track 9
      Testcontainers)?

---

## You'll know it worked when:

- [ ] The app starts on a fresh DB and Flyway builds the whole schema
- [ ] `ddl-auto: validate` passes (entities match the migrated schema)
- [ ] Editing an applied migration triggers a checksum failure (then reverted)
- [ ] Changing the repeatable view re-applies it on restart
