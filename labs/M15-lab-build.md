# M15 Lab — Build It with AI Path

> **Module:** M15 · Transactions & Caching
> **Track:** Data Access with JPA
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Make the decision flow atomic and cache the slow policy lookup — then prove rollback and cache
hits actually happen.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: Atomic Decision (15 min)

Ask Claude Code:

> "Make `PriorAuthService.decide(authNumber, decision)` `@Transactional`: update the
> `PriorAuth` status and insert an `AuditEntry` in the same method. Then write a test that forces
> the audit insert to fail and asserts the status change was rolled back."

Run the test and confirm the rollback. **Review:** Is `@Transactional` on the service method
(not the controller or repository)?

---

## Step 2: Prove the Proxy Pitfall (10 min)

> "Add a `@Transactional(propagation = REQUIRES_NEW)` `record(...)` method and call it (a) via
> `this.record(...)` and (b) via an injected self-reference. Show that only the external call
> honors the new transaction."

**Your judgment call:** Explain why (a) silently ignores the annotation — tie it back to M03.

---

## Step 3: Cache the Policy Lookup (15 min)

> "Add `@EnableCaching` and Caffeine. Annotate `policyFor(cptCode)` with `@Cacheable("policies",
> key=\"#cptCode\")` and `refreshPolicy(cptCode)` with `@CacheEvict`. Log inside `policyFor` so I
> can see when the real method runs."

Verify hits skip the method:

```powershell
# call twice with the same cptCode — the log should print once
curl http://localhost:8080/api/prior-auths/reports/policy/70553
curl http://localhost:8080/api/prior-auths/reports/policy/70553
```

---

## Step 4: Reflect (10 min)

- [ ] What would corrupt data if `decide` were *not* transactional?
- [ ] When is `REQUIRES_NEW` the right call, and when is it a trap?
- [ ] How will the cache choice (Caffeine vs Redis) change once this becomes microservices (Track 6)?

---

## You'll know it worked when:

- [ ] A forced failure rolls back the whole decision
- [ ] The self-invocation call demonstrably skips the new-transaction setting
- [ ] A repeated `policyFor` logs the real call only once (cache hit)
- [ ] `@CacheEvict` forces the next call to run again
