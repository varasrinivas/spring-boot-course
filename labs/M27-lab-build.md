# M27 Lab — Build It with AI Path

> **Module:** M27 · Saga Pattern
> **Track:** Inter-Service Communication
> **Time:** ~60 minutes
> **Requires:** Claude Code, JDK 21, Docker (Kafka)

---

## Goal

Implement a submit-prior-auth saga across intake → eligibility → review with compensations, and
prove it recovers from a mid-flight failure.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: Orchestrated Happy Path (20 min)

Ask Claude Code:

> "Create a `SubmitPriorAuthSaga` orchestrator with steps: `intake.create`,
> `eligibility.reserve`, `review.assign`. Persist a `PriorAuthSaga` state entity (PENDING →
> ELIGIBILITY_RESERVED → ASSIGNED → COMPLETED). Run the full happy path for one submission."

**Review:** Is state persisted *after each step* (so a crash is recoverable)?

---

## Step 2: Compensations (20 min)

> "Add compensating actions: `eligibility.cancelReservation` and `intake.markFailed`. Force
> `review.assign` to throw and show the saga runs C2 then C1, ending in FAILED with no orphaned
> reservation."

```powershell
# trigger a submission where assignment is configured to fail
curl -X POST http://localhost:8080/api/prior-auths -d '{"...":"forceAssignFailure"}'
# verify: reservation cancelled, request marked failed
```

---

## Step 3: Idempotency & Recovery (15 min)

> "Make `reserve`/`cancelReservation` idempotent (keyed by authNumber). Add a recovery job that
> finds sagas stuck in a non-terminal state past a timeout and resumes or compensates them. Show
> a redelivered step does not double-reserve."

**Your judgment call:** Kill the app mid-saga; on restart, does the recovery job finish or
compensate it?

---

## Step 4: Reflect (5 min)

- [ ] What consistency guarantee did you give up vs the monolith's `@Transactional`?
- [ ] Where would choreography have been simpler, and where would it have hidden the flow?
- [ ] Which steps were hardest to design a compensation for?

---

## You'll know it worked when:

- [ ] The happy path advances the saga to COMPLETED
- [ ] A mid-saga failure compensates cleanly (no orphaned state)
- [ ] Redelivered steps are idempotent
- [ ] A crashed saga is resumed or compensated by recovery
