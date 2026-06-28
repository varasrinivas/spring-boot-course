# M28 Lab — Build It with AI Path

> **Module:** M28 · Event Sourcing & CQRS
> **Track:** Inter-Service Communication
> **Time:** ~60 minutes
> **Requires:** Claude Code, JDK 21

---

## Goal

Event-source the prior-auth *decision* domain: append events, derive state by replay, and build
two projections — proving you can rebuild a read model from the log.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: Event Store + Derived State (20 min)

Ask Claude Code:

> "In `prior-auth-review`, model the decision domain with events (`PriorAuthSubmitted`,
> `EligibilityReserved`, `PriorAuthDecided`) appended to an `event_store` table keyed by
> `authNumber` + sequence. Implement `load(authNumber)` that derives current state by folding the
> events. Commands append events; they never UPDATE state."

**Review:** Is there *no* current-state table that gets overwritten? Is state always derived?

---

## Step 2: Two Projections (20 min)

> "Add a `ReviewerDashboardProjection` (pending items) and an `AuditTrailProjection` (every event
> with timestamp + actor), each an `@EventHandler` updating its own read table. Serve a dashboard
> endpoint and an audit endpoint from these read models."

```powershell
curl http://localhost:8080/api/review/dashboard
curl http://localhost:8080/api/prior-auths/PA-1/audit
```

---

## Step 3: Rebuild from the Log (15 min)

> "Add an admin endpoint that drops and rebuilds the `ReviewerDashboard` read model by replaying
> all events. Then add a NEW projection (`DenialsByReviewer`) retroactively over the full history."

**Your judgment call:** The new projection answers a question nobody designed for originally. Why
is that possible here but not with CRUD?

---

## Step 4: Reflect (5 min)

- [ ] What did you gain for the decision domain specifically (think compliance)?
- [ ] What complexity did you take on?
- [ ] Why keep patient/reference data as plain JPA instead?

---

## You'll know it worked when:

- [ ] State is derived from an append-only event store, never overwritten
- [ ] Two projections serve different read models from the same log
- [ ] A read model rebuilds correctly by replaying events
- [ ] A new projection answers a historical question retroactively
