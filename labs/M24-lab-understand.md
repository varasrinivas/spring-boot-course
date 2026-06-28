# M24 Lab — Understand It Path

> **Module:** M24 · API Gateway
> **Track:** Microservices Foundations
> **Time:** ~30 minutes

---

## Goal

Understand how the gateway routes and applies edge concerns for the prior-auth fleet.

---

## Part 1: Read the Routes (10 min)

```yaml
routes:
  - id: intake
    uri: lb://prior-auth-intake
    predicates: [ Path=/api/prior-auths/**, Method=POST ]
  - id: review
    uri: lb://prior-auth-review
    predicates: [ Path=/api/prior-auths/*/decision ]
    filters: [ "RewritePath=/api/prior-auths/(?<id>.*)/decision, /decisions/${id}" ]
```

**Questions:**

1. A `PATCH /api/prior-auths/PA-1/decision` arrives. Which route matches, and what internal path
   does the service receive?
2. What does `lb://` do that `http://host:port` would not?
3. If the `review` route were listed *before* a broad `Path=/api/prior-auths/**` route, why would
   ordering matter?
4. Where would you validate the JWT — at the gateway, each service, or both? Why?

---

## Part 2: Predicate or Filter? (10 min)

| Need | Predicate or Filter? |
|------|---------------------|
| Only match POSTs | |
| Strip a public path prefix | |
| Add a correlation header | |
| Match a specific host header | |

---

## Part 3: Edge Concerns (10 min)

| Question | Your Answer |
|----------|-------------|
| Why centralize rate limiting at the gateway vs in each service? | |
| What backs the `RequestRateLimiter` and why? | |
| Why do internal services stay simpler with a gateway in front? | |
| What's the risk of clients calling services directly? | |

---

## You'll know it worked when:

- [ ] You can trace a request through route matching to a service
- [ ] You can distinguish predicates from filters
- [ ] You can explain `lb://` + discovery integration
- [ ] You can justify edge-level auth, rate limiting, CORS
