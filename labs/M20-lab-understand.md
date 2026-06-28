# M20 Lab — Understand It Path

> **Module:** M20 · Method-Level Security
> **Track:** Spring Security
> **Time:** ~30 minutes

---

## Goal

Reason about per-method and per-object authorization, and why you must test both the allowed and
forbidden paths.

---

## Part 1: Read the Code (10 min)

```java
@PreAuthorize("hasRole('REVIEWER') and @assignments.isAssignedTo(#authNumber, authentication.name)")
public PriorAuthResponse decide(String authNumber, Decision decision) { ... }

@PostAuthorize("returnObject.assignedReviewer == authentication.name")
public PriorAuthResponse get(String authNumber) { ... }
```

**Questions:**

1. A `REVIEWER` calls `decide("PA-1", ...)` but `PA-1` is assigned to a different reviewer. Allowed?
   Which part of the expression stops it?
2. Why does `@PostAuthorize` on `get` have to run *after* the method, not before?
3. What does `#authNumber` refer to, and where does `authentication.name` come from?
4. Why push the assignment check into an `@assignments` bean instead of inlining it?

---

## Part 2: URL vs Method (10 min)

| Rule | Best layer (URL / method) | Why |
|------|---------------------------|-----|
| `/api/prior-auths/**` requires auth | | |
| Only REVIEWER may decide | | |
| Reviewer may decide only assigned auths | | |
| `/actuator/health` is public | | |

---

## Part 3: Test Design (10 min)

For the `decide` operation, list the test cases you'd write (role × ownership) and the expected
status for each. Why is the negative case (`SUBMITTER` → 403) as important as the positive one?

---

## You'll know it worked when:

- [ ] You can choose URL vs method security per rule
- [ ] You can explain @PreAuthorize vs @PostAuthorize
- [ ] You can read a SpEL expression accessing args/principal/bean
- [ ] You can design a role × operation test matrix
