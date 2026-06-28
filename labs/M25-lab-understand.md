# M25 Lab — Understand It Path

> **Module:** M25 · Synchronous Communication
> **Track:** Inter-Service Communication
> **Time:** ~30 minutes

---

## Goal

Reason about synchronous calls between services and why timeouts are mandatory.

---

## Part 1: Read the Code (10 min)

```java
@HttpExchange("/api/eligibility")
public interface EligibilityClient {
    @GetExchange("/{member}")
    Eligibility check(@PathVariable String member);
}

Eligibility e = restClient.get()
    .uri("http://eligibility-service/api/eligibility/{member}", memberId)
    .retrieve().body(Eligibility.class);
```

**Questions:**

1. `eligibility-service` isn't a real host. How does the call reach an instance? (Recall M23.)
2. What does `review` do while waiting for the response — and what is that coupling called?
3. Why prefer the `@HttpExchange` interface over the inline `RestClient` call for repeated use?
4. RestClient vs WebClient — when would you switch to WebClient?

---

## Part 2: Sync or Async? (10 min)

| Interaction | Sync or Async? | Why |
|-------------|----------------|-----|
| Review needs eligibility to decide | | |
| Notify the provider of a decision | | |
| Audit-log an action | | |

---

## Part 3: Failure Modes (10 min)

| Question | Your Answer |
|----------|-------------|
| `eligibility-service` hangs and you set NO read timeout. What happens to `review`? | |
| With a 3s read timeout, what happens instead? | |
| A `503` comes back. How should `review` treat it? | |
| Which Track 8 patterns build on these timeouts? | |

---

## You'll know it worked when:

- [ ] You can explain temporal coupling
- [ ] You can choose sync vs async per interaction
- [ ] You can describe a cascade from a missing timeout
- [ ] You can read a declarative client interface
