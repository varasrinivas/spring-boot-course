# M14 Lab — Understand It Path

> **Module:** M14 · Custom Queries & Specifications
> **Track:** Data Access with JPA
> **Time:** ~30 minutes

---

## Goal

Know which query tool to reach for — derived name, `@Query` (JPQL or native), projection, or
Specification — and understand how Specifications power dynamic filtering.

---

## Part 1: Read the Code (10 min)

```java
@Query("select p from PriorAuth p where p.status = :status and p.requestDate >= :since")
List<PriorAuth> findActiveSince(@Param("status") AuthStatus status, @Param("since") LocalDate since);

public static Specification<PriorAuth> byStatus(AuthStatus s) {
    return (root, query, cb) -> s == null ? null : cb.equal(root.get("status"), s);
}

repo.findAll(where(byStatus(status)).and(cptCodeIs(cpt)), pageable);
```

**Questions to answer:**

1. In the JPQL, `PriorAuth` and `p.status` refer to the entity and field — what table and column
   do they become? Why is JPQL more portable than native SQL?
2. Why are `:status`/`:since` bound parameters safe, where string concatenation would not be?
3. When `cpt` is `null`, what does `cptCodeIs(cpt)` return, and what happens to the WHERE clause?
4. Which repository interface must `repo` extend for `findAll(spec, pageable)` to exist?

---

## Part 2: Pick the Right Tool (10 min)

| Need | Best tool |
|------|-----------|
| `findByStatus` | |
| Approved-count grouped by CPT code | |
| Fixed multi-condition read with a join | |
| Search with any combination of optional filters | |

---

## Part 3: Predict (10 min)

| Question | Your Answer |
|----------|-------------|
| A projection interface `CptCount` has `getCptCode()`/`getCnt()`. What does a query return for it? | |
| What is a `Specification<T>` in terms of the Criteria API? | |
| Why is the Criteria API rarely written raw in app code? | |
| How does the M12 list endpoint's optional filtering actually work now? | |

---

## You'll know it worked when:

- [ ] You can choose between derived/@Query/native/Specification per use case
- [ ] You can explain JPQL vs native SQL and why bound params are safe
- [ ] You can describe how `null` specs drop out of a composition
- [ ] You can connect Specifications back to the M12 endpoint
