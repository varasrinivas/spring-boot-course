# M29 Lab — Understand It Path

> **Module:** M29 · Circuit Breakers & Retry
> **Track:** Resilience & Observability
> **Time:** ~30 minutes

---

## Goal

Reason about resilient remote calls: which pattern for which failure, and how a circuit breaker
prevents cascades.

---

## Part 1: Read the Code (10 min)

```java
@Retry(name = "eligibility")
@CircuitBreaker(name = "eligibility", fallbackMethod = "eligibilityFallback")
public Eligibility check(String memberId) { return eligibilityClient.check(memberId); }

private Eligibility eligibilityFallback(String memberId, Throwable t) {
    return Eligibility.unknown();   // → manual review
}
```

**Questions:**

1. `eligibility-service` is fully down. Walk through CLOSED → OPEN and what each `review` request
   experiences before vs after the breaker trips.
2. Why retry only *idempotent* operations and *retryable* errors (not a 400)?
3. When the breaker is OPEN, what does `check` return, and what does the business do?
4. Why is "route to manual review" a *good* fallback rather than denying the request?

---

## Part 2: Pattern → Failure (10 min)

| Failure | Best pattern |
|---------|-------------|
| One dropped packet | |
| Dependency down for 5 minutes | |
| Partner API quota of 10/sec | |
| An async call that may never return | |

---

## Part 3: Cascade (10 min)

1. With NO circuit breaker and a down dependency, describe how `review` itself fails.
2. With the breaker, what stops that?
3. Why does retry *wrap* the circuit breaker rather than the reverse?

---

## You'll know it worked when:

- [ ] You can name the circuit breaker states and transitions
- [ ] You can match each failure to a pattern
- [ ] You can explain a cascade and how the breaker prevents it
- [ ] You can design a useful fallback
