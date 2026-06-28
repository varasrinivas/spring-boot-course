# M21 Lab — Build It with AI Path

> **Module:** M21 · Monolith to Microservices
> **Track:** Microservices Foundations
> **Time:** ~45 minutes
> **Requires:** Claude Code, JDK 21

---

## Goal

Plan the decomposition concretely: a multi-module workspace and a decomposition document for the
Prior Authorization platform. (Later modules implement the infrastructure.)

---

## Setup

```powershell
cd C:\Projects
claude
```

---

## Step 1: Carve the Services (15 min)

Ask Claude Code:

> "Given my prior-auth monolith, propose a decomposition into bounded-context services (intake,
> review, eligibility, notification). For each: its responsibility, the data it owns, the
> entities that move with it, and the APIs/events other services need from it."

**Review:** Does each service own a cohesive slice? Are there any tables two services both want
to own (a sign your boundary is wrong)?

---

## Step 2: Scaffold the Workspace (15 min)

> "Create a multi-module Maven workspace `prior-auth-platform` with empty Spring Boot modules:
> `api-gateway`, `prior-auth-intake`, `prior-auth-review`, `eligibility-service`,
> `notification-service`, `config-server`, `discovery-server`. Move the existing intake/review
> code into the matching modules; give each service its own datasource config."

**Your judgment call:** Resist sharing a database between modules — wire each to its own schema.

---

## Step 3: Document the Contracts (15 min)

> "Write a `DECOMPOSITION.md`: for each pair of services that must exchange data, decide
> synchronous (HTTP) vs asynchronous (event) and why. E.g. Review needs eligibility → sync call;
> a decision made → event consumed by Notification."

---

## Step 4: Reflect (no code)

- [ ] Which boundary were you least sure about, and what would you measure to decide?
- [ ] Where did you feel the pull to share a database, and how did you resist it?
- [ ] Which couplings are sync vs async, and why?

---

## You'll know it worked when:

- [ ] You have a clear service-by-service responsibility + data-ownership map
- [ ] A scaffolded multi-module workspace with no shared database
- [ ] A documented set of inter-service contracts (sync vs async)
- [ ] You can defend each boundary as a bounded context
