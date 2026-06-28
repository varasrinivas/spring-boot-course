# M29 Lab — Build It with AI Path

> **Module:** M29 · Circuit Breakers & Retry
> **Track:** Resilience & Observability
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21

---

## Goal

Protect the `review → eligibility` call with retry, a circuit breaker, and a fallback to manual
review — then prove the breaker trips and recovers.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: Circuit Breaker + Fallback (20 min)

Ask Claude Code:

> "Add `resilience4j-spring-boot3` to `prior-auth-review`. Annotate the eligibility call with
> `@CircuitBreaker(name=\"eligibility\", fallbackMethod=\"eligibilityFallback\")`; the fallback
> returns an `Eligibility.unknown()` that routes the auth to manual review. Configure a 50%
> failure threshold and 10s open state."

**Review:** Does the fallback have the same signature plus a `Throwable`?

---

## Step 2: Trip It (15 min)

> "Add a stub eligibility that fails. Send enough requests to trip the breaker, then show
> subsequent calls failing fast (fallback) without hitting the stub. Expose the breaker state via
> `/actuator/health` or the resilience4j endpoint."

```powershell
1..20 | ForEach-Object { curl -s http://localhost:8083/api/review/check/M1002934 }
# observe: real calls, then fast fallbacks once OPEN
```

**Your judgment call:** After 10s, what state does it move to, and what does one trial call do?

---

## Step 3: Retry + Tuning (15 min)

> "Add `@Retry(name=\"eligibility\")` with 3 attempts and exponential backoff for transient
> failures, layered with the breaker. Make a transient stub (fails once, then succeeds) and show
> the retry recovers without tripping the breaker. Tune everything in application.yml."

---

## Step 4: Reflect (no code)

- [ ] How does `review` behave now when eligibility is down vs briefly flaky?
- [ ] What did the fallback let the business keep doing?
- [ ] Which values would you tune for a slow-but-not-dead dependency?

---

## You'll know it worked when:

- [ ] The breaker trips under sustained failure and calls fail fast
- [ ] After the wait, HALF_OPEN trials close or re-open it
- [ ] Retry recovers a transient blip without tripping the breaker
- [ ] The fallback routes to manual review instead of failing the request
