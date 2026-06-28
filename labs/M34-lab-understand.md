# M34 Lab — Understand It Path

> **Module:** M34 · Docker Compose
> **Track:** Containerization & Deployment
> **Time:** ~30 minutes

---

## Goal

Understand declaring a multi-service stack, name-based networking, persistence, and health-gated
startup.

---

## Part 1: Read the Compose (10 min)

```yaml
services:
  postgres:
    image: postgres:16
    healthcheck: { test: ["CMD-SHELL","pg_isready -U postgres"], interval: 5s, retries: 5 }
    volumes: ["pgdata:/var/lib/postgresql/data"]
  prior-auth-review:
    build: ./prior-auth-review
    environment: { SPRING_DATASOURCE_URL: "jdbc:postgresql://postgres:5432/priorauth" }
    depends_on: { postgres: { condition: service_healthy } }
volumes: { pgdata: {} }
```

**Questions:**

1. The datasource URL uses host `postgres`. There's no IP anywhere — how does it resolve?
2. What's the difference between `depends_on` alone and `depends_on: condition: service_healthy`?
3. Why the `pgdata` volume — what would happen to the data without it on `compose down`?
4. Where do these `environment` values map in the Spring app (recall M07)?

---

## Part 2: Concept Map (10 min)

| Compose concept | Job |
|-----------------|-----|
| service | |
| network (default) | |
| volume | |
| healthcheck | |

---

## Part 3: Compose vs K8s (10 min)

| Question | Your Answer |
|----------|-------------|
| Two good uses for Compose | |
| Three things Compose can't do that prod needs | |
| What runs the SAME images in production? | |
| Does moving to K8s change your M33 images? | |

---

## You'll know it worked when:

- [ ] You can explain service-name networking
- [ ] You can explain health-gated startup
- [ ] You can say why volumes persist data
- [ ] You can place Compose vs Kubernetes
