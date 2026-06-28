# M13 Lab — Build It with AI Path

> **Module:** M13 · Entities & Repositories
> **Track:** Data Access with JPA
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Give the Prior Authorization Service a real database: map the `PriorAuth` entity, get a
repository for free, write derived queries, and run it on H2 (dev) — wiring up PostgreSQL config
for prod. Claude Code writes the mapping; you verify rows actually persist.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

> Ensure `spring-boot-starter-data-jpa` and the `h2` (runtime) dependency are present.

---

## Step 1: Map the Entity (15 min)

Ask Claude Code:

> "Convert `PriorAuth` into a JPA `@Entity` mapped to table `prior_auth`: `@Id
> @GeneratedValue(IDENTITY) Long id`, a unique non-null `authNumber`, `patientMemberId`,
> `cptCode`, an `@Enumerated(STRING) AuthStatus status`, and a `LocalDate requestDate`. Keep the
> API DTOs (`SubmitPriorAuthRequest`/`PriorAuthResponse`) separate from the entity."

**Review:** Is the entity distinct from the DTOs? Is `status` stored as text, not an ordinal?

---

## Step 2: Repository + Persist (15 min)

> "Create `PriorAuthRepository extends JpaRepository<PriorAuth, Long>`. Have `PriorAuthService`
> use it to save on submit and load on read. Enable the H2 console and SQL logging
> (`spring.jpa.show-sql=true`)."

Submit one and confirm it persisted:

```powershell
curl -X POST http://localhost:8080/api/prior-auths -H "Content-Type: application/json" `
  -d '{"patientMemberId":"M1002934","providerNpi":"1083948272","cptCode":"70553"}'
# open the H2 console and SELECT * FROM prior_auth
Start-Process "http://localhost:8080/h2-console"
```

Watch the logged `insert into prior_auth ...` SQL.

---

## Step 3: Derived Queries (15 min)

> "Add `findByAuthNumber`, `findByStatus(AuthStatus, Pageable)`,
> `findByPatientMemberIdAndStatus`, `countByStatus`, and `existsByAuthNumber`. Wire
> `findByStatus` into the M12 list endpoint's filtering and have the not-found path throw
> `PriorAuthNotFoundException`."

Test them:

```powershell
curl "http://localhost:8080/api/prior-auths?status=PENDING&page=0&size=20"
curl http://localhost:8080/api/prior-auths/PA-2026-000123
```

**Your judgment call:** How many lines of SQL did you write for all of this? (Aim: zero.)

---

## Step 4: Reflect (5 min)

- [ ] Which methods came free from `JpaRepository`, and which did you derive by naming?
- [ ] Why keep the entity separate from the request/response DTOs?
- [ ] What would you change in config to run this on PostgreSQL in prod?

---

## You'll know it worked when:

- [ ] A submitted prior-auth is a row in `prior_auth` (seen in the H2 console)
- [ ] Reads, filters, and counts work via derived methods — no hand-written SQL
- [ ] The entity and API DTOs are separate types
- [ ] You can point to the config that would switch dev H2 → prod PostgreSQL
