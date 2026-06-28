# M16 Lab — Understand It Path

> **Module:** M16 · Database Migrations
> **Track:** Data Access with JPA
> **Time:** ~30 minutes

---

## Goal

Understand how Flyway makes the Prior Authorization Service's schema versioned, reproducible, and
safe — and how it pairs with JPA validation.

---

## Part 1: Read the Migrations (10 min)

```sql
-- V1__create_prior_auth.sql
create table prior_auth ( id bigserial primary key, auth_number varchar(20) not null unique,
    cpt_code varchar(5) not null, status varchar(20) not null, request_date date not null );

-- V2__add_priority.sql
alter table prior_auth add column priority varchar(10) not null default 'ROUTINE';

-- R__pending_by_cpt.sql
create or replace view pending_by_cpt as
    select cpt_code, count(*) as cnt from prior_auth where status = 'PENDING' group by cpt_code;
```

**Questions:**

1. On a brand-new database, which scripts run and in what order? On a database already at V2?
2. You realize V2's default should be `URGENT`, not `ROUTINE`. Why must you NOT edit V2 — what do
   you do instead?
3. Why is `R__pending_by_cpt.sql` a repeatable migration rather than a versioned one?
4. Where does Flyway record what it has applied?

---

## Part 2: ddl-auto Modes (10 min)

| Mode | What it does | Where it belongs |
|------|--------------|------------------|
| `update` | | |
| `validate` | | |
| `none` | | |

Why is `validate` the right pairing with Flyway?

---

## Part 3: Predict (10 min)

| Question | Your Answer |
|----------|-------------|
| An applied migration's checksum no longer matches its file. What does Flyway do at startup? | |
| Your entity adds a field but no migration adds the column. What does `ddl-auto: validate` do? | |
| Why run the same migrations in tests as in production? | |
| What's the advantage of additive, backward-compatible migrations during a rolling deploy? | |

---

## You'll know it worked when:

- [ ] You can explain why migrations beat ddl-auto for shared environments
- [ ] You can order versioned vs repeatable application
- [ ] You can state why applied migrations are immutable
- [ ] You can explain the Flyway + validate handoff
