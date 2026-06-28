# M24 Lab — Build It with AI Path

> **Module:** M24 · API Gateway
> **Track:** Microservices Foundations
> **Time:** ~55 minutes
> **Requires:** Claude Code, JDK 21, Docker (Redis)

---

## Goal

Put a Spring Cloud Gateway in front of the prior-auth services: route by path to discovered
services, rewrite a path, and enforce auth + rate limiting at the edge.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: Gateway + Routes (15 min)

Ask Claude Code:

> "Create an `api-gateway` (Spring Cloud Gateway) on 8080 that is also a Eureka client. Add
> routes: POST `/api/prior-auths/**` → `lb://prior-auth-intake`; `/api/prior-auths/*/decision` →
> `lb://prior-auth-review`; `/api/eligibility/**` → `lb://eligibility-service`."

```powershell
curl -X POST http://localhost:8080/api/prior-auths -H "Content-Type: application/json" -d '{...}'
curl http://localhost:8080/api/eligibility/M1002934
```

**Review:** Are routes ordered specific-before-general? Do they use `lb://`?

---

## Step 2: Rewrite a Path (10 min)

> "On the review route, add `RewritePath=/api/prior-auths/(?<id>.*)/decision, /decisions/${id}`
> so the public path maps to the review service's internal `/decisions/{id}`. Verify the service
> receives the rewritten path."

---

## Step 3: Auth + Rate Limit at the Edge (20 min)

> "Validate the JWT at the gateway (oauth2 resource server) so unauthenticated requests are
> rejected before routing. Add a Redis-backed `RequestRateLimiter` (replenishRate 10, burst 20)
> keyed by the authenticated user. Run Redis in Docker."

```powershell
# hammer the endpoint to see 429 Too Many Requests
1..30 | ForEach-Object { curl -s -o /dev/null -w "%{http_code}`n" http://localhost:8080/api/prior-auths -H "Authorization: Bearer $token" }
```

**Your judgment call:** At what point do you see `429`? Is the limit per-user as intended?

---

## Step 4: Reflect (10 min)

- [ ] How many public endpoints do external clients now know? (Aim: one host.)
- [ ] Which concerns did you move from services to the gateway?
- [ ] Why keep a lighter auth check in services too (defense in depth)?

---

## You'll know it worked when:

- [ ] All prior-auth calls work through the single gateway host
- [ ] The review path is rewritten to the service's internal path
- [ ] Unauthenticated requests are rejected at the gateway
- [ ] Exceeding the rate limit returns `429`
