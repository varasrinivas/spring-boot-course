# M23 Lab — Build It with AI Path

> **Module:** M23 · Service Discovery
> **Track:** Microservices Foundations
> **Time:** ~55 minutes
> **Requires:** Claude Code, JDK 21

---

## Goal

Run a Eureka registry, register the prior-auth services, and call one by name with client-side
load balancing — then watch the registry self-heal.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: Eureka Server (15 min)

Ask Claude Code:

> "Create a `discovery-server` Spring Boot app with `@EnableEurekaServer` on port 8761. Show the
> Eureka dashboard."

```powershell
Start-Process "http://localhost:8761"
```

---

## Step 2: Register Services (15 min)

> "Make `eligibility-service` and `review-service` Eureka clients (set `spring.application.name`
> and the eureka service-url). Start two instances of `eligibility-service` on different ports
> and confirm both appear in the dashboard."

**Review:** Do you see `ELIGIBILITY-SERVICE` with two instances registered?

---

## Step 3: Call by Name + Balance (15 min)

> "In `review-service`, add a `@LoadBalanced RestClient.Builder` and call
> `http://eligibility-service/api/eligibility/{member}`. Log which instance served each call, and
> make several calls to show round-robin balancing."

```powershell
1..6 | ForEach-Object { curl http://localhost:8083/api/review/check/M1002934 }
# observe the instance alternating
```

**Your judgment call:** Kill one eligibility instance. After its lease expires, confirm calls
still succeed (routed only to the survivor).

---

## Step 4: Reflect (5 min)

- [ ] How many URLs/ports are hardcoded in `review-service` now? (Aim: zero.)
- [ ] What happened to traffic when an instance died?
- [ ] How will this differ under Kubernetes (preview of M35)?

---

## You'll know it worked when:

- [ ] Both eligibility instances register in Eureka
- [ ] `review-service` calls by name and round-robins across instances
- [ ] Killing an instance removes it from rotation automatically
- [ ] No host:port appears in the calling code
