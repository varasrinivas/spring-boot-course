# M34 Lab — Build It with AI Path

> **Module:** M34 · Docker Compose
> **Track:** Containerization & Deployment
> **Time:** ~55 minutes
> **Requires:** Claude Code, JDK 21, Docker

---

## Goal

Bring the whole prior-auth platform up locally with one Compose file, with health-gated startup
and persistent data.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: Core Stack (20 min)

Ask Claude Code:

> "Write a `docker-compose.yml` with: `postgres` (with a healthcheck and a `pgdata` volume),
> `prior-auth-review` and `eligibility-service` (built from their Dockerfiles), and the
> `discovery-server`. Wire datasource/eureka URLs by service name. Bring it up."

```powershell
docker compose up --build
docker compose ps
```

**Review:** Do the services reach Postgres and discovery by service name (no IPs/ports hardcoded)?

---

## Step 2: Health-Gated Startup (15 min)

> "Add `depends_on: condition: service_healthy` so the services wait for Postgres to be ready, and
> add a Spring healthcheck hitting `/actuator/health/readiness`. Force Postgres to start slowly
> and show the apps wait instead of crashing."

**Your judgment call:** Remove the healthcheck condition and observe a startup-race crash. Then
restore it.

---

## Step 3: Add Infra (15 min)

> "Add Kafka and Zipkin services and wire review/notification and tracing to them by name. Bring
> the full stack up and confirm a submission flows end to end, with a trace appearing in Zipkin."

```powershell
docker compose up --build
Start-Process "http://localhost:9411"   # Zipkin
```

---

## Step 4: Reflect (5 min)

- [ ] How long from `git clone` to a running platform now?
- [ ] What did health-gated startup prevent?
- [ ] Why is this stack good for CI integration tests but not production?

---

## You'll know it worked when:

- [ ] `docker compose up` starts the whole platform
- [ ] Services connect by name; data persists across `down`/`up`
- [ ] Apps wait for healthy dependencies, no startup races
- [ ] An end-to-end submission works and is traced
