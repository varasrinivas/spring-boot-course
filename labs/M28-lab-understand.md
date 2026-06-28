# M28 Lab — Understand It Path

> **Module:** M28 · Event Sourcing & CQRS
> **Track:** Inter-Service Communication
> **Time:** ~30 minutes

---

## Goal

Understand storing events vs state, deriving views via projections, and judging when the pattern
is worth it — for prior-auth decisions.

---

## Part 1: Read the Code (10 min)

```java
PriorAuth state = eventStore.eventsFor(authNumber).reduce(PriorAuth.initial(), PriorAuth::apply);

@EventHandler void on(PriorAuthSubmitted e) { dashboard.addPending(e.authNumber(), e.cptCode()); }
@EventHandler void on(PriorAuthDecided e)   { dashboard.markDecided(e.authNumber(), e.decision()); }
```

**Questions:**

1. Where is the "current status" of an authorization actually stored? How do you get it?
2. A CRUD `UPDATE status='APPROVED'` loses what that an event log keeps?
3. You want a brand-new "denials by reviewer" report covering all of history. How, with events?
4. What is the consistency relationship between the write side and the dashboard read model?

---

## Part 2: CRUD vs Event-Sourced (10 min)

| Question | CRUD | Event-Sourced |
|----------|------|---------------|
| Where is history? | | |
| "State as of last Tuesday"? | | |
| Cost of "get current status" | | |
| Add a new read view later | | |

---

## Part 3: When to Use (10 min)

For each, decide event-sourcing/CQRS or plain JPA, and why:

| Domain | Choice | Why |
|--------|--------|-----|
| Prior-auth decision history (audited) | | |
| Patient reference data (names, addresses) | | |
| A simple settings table | | |

---

## You'll know it worked when:

- [ ] You can explain deriving state by replay
- [ ] You can list what CRUD loses
- [ ] You can describe projections as rebuildable views
- [ ] You can judge where the pattern is (and isn't) worth it
