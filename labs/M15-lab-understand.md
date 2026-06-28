# M15 Lab — Understand It Path

> **Module:** M15 · Transactions & Caching
> **Track:** Data Access with JPA
> **Time:** ~30 minutes

---

## Goal

Reason about atomicity, propagation, isolation, and caching on the Prior Authorization Service.

---

## Part 1: Read the Code (10 min)

```java
@Transactional
public PriorAuthResponse decide(String authNumber, Decision decision) {
    PriorAuth pa = repo.findByAuthNumber(authNumber)
        .orElseThrow(() -> new PriorAuthNotFoundException(authNumber));
    pa.setStatus(decision.toStatus());
    auditRepo.save(new AuditEntry(authNumber, decision));
    return toResponse(pa);
}

@Cacheable(value = "policies", key = "#cptCode")
public Policy policyFor(String cptCode) { return payerClient.fetchPolicy(cptCode); }
```

**Questions:**

1. The audit insert throws a `DataIntegrityViolationException`. What happens to the status
   update? Why?
2. If `decide` called `this.record(...)` (a `@Transactional` method) directly, would the
   propagation setting take effect? Why or why not? (Recall M03.)
3. The second call to `policyFor("70553")` — does it hit the payer API? What returns it?
4. After `refreshPolicy("70553")` runs with `@CacheEvict`, what does the next `policyFor("70553")`
   do?

---

## Part 2: Propagation & Isolation (10 min)

| Scenario | REQUIRED | REQUIRES_NEW |
|----------|----------|--------------|
| Outer rolls back after inner completes — does inner's write survive? | | |
| Number of commits | | |

Which isolation level is the common default, and which anomaly does it prevent?

---

## Part 3: Predict (10 min)

| Question | Your Answer |
|----------|-------------|
| Why mark a read-only list method `@Transactional(readOnly = true)`? | |
| Where should `@Transactional` live — controller, service, or repository? | |
| What backs the cache, and what's the difference between Caffeine and Redis here? | |
| Why are both `@Transactional` and `@Cacheable` subject to the self-invocation gotcha? | |

---

## You'll know it worked when:

- [ ] You can explain atomic commit/rollback for a multi-write method
- [ ] You can contrast REQUIRED vs REQUIRES_NEW
- [ ] You can place isolation levels against the anomalies they prevent
- [ ] You can trace a cache hit vs miss and an evict
