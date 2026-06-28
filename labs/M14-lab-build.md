# M14 Lab — Build It with AI Path

> **Module:** M14 · Custom Queries & Specifications
> **Track:** Data Access with JPA
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Go beyond derived methods: add a JPQL query, a native aggregate with a projection, and real
Specifications that power the M12 list endpoint's optional filters — with Claude Code.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: A JPQL Query (10 min)

Ask Claude Code:

> "Add a repository method `findActiveSince(AuthStatus status, LocalDate since)` using `@Query`
> with JPQL over the `PriorAuth` entity and `@Param` binding. Expose it as `GET
> /api/prior-auths/active?since=2026-01-01`."

**Review:** Does the JPQL reference the entity/fields (not table/columns)? Are params bound, not
concatenated?

---

## Step 2: Native Aggregate + Projection (15 min)

> "Add a native query `topApprovedCpts()` returning approved-count grouped by `cpt_code`,
> ordered descending, mapped to an interface projection `CptCount { String getCptCode(); long
> getCnt(); }`. Expose it at `GET /api/prior-auths/reports/top-cpts`."

```powershell
curl http://localhost:8080/api/prior-auths/reports/top-cpts
```

**Your judgment call:** Why a projection rather than returning full `PriorAuth` entities here?

---

## Step 3: Real Specifications (20 min)

> "Make `PriorAuthRepository` also extend `JpaSpecificationExecutor<PriorAuth>`. Create a
> `PriorAuthSpecs` class with `byStatus`, `cptCodeIs`, and `requestedAfter` specifications that
> return `null` when their argument is null. Rewrite the M12 list endpoint to compose them with
> `where(...).and(...)` and call `repo.findAll(spec, pageable)`."

Test that omitting filters widens, not empties, the result:

```powershell
curl "http://localhost:8080/api/prior-auths?status=PENDING&cptCode=70553&page=0&size=20"
curl "http://localhost:8080/api/prior-auths?status=PENDING"
curl "http://localhost:8080/api/prior-auths"
```

---

## Step 4: Reflect (5 min)

- [ ] Which queries did you express as JPQL, native, and Specifications — and why each?
- [ ] How do `null`-returning specs keep the composition clean vs `if` branches?
- [ ] How is this the same mechanism you used at the REST layer in M12?

---

## You'll know it worked when:

- [ ] The JPQL `active` endpoint returns the right rows with bound params
- [ ] The native report returns a projected count-by-CPT list
- [ ] Composed Specifications drive the list endpoint; omitting a filter widens results
- [ ] You wrote no concatenated SQL anywhere
