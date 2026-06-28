# M36 Lab — Understand It Path

> **Module:** M36 · CI/CD Pipeline
> **Track:** Containerization & Deployment
> **Time:** ~30 minutes

---

## Goal

Understand the commit-to-cluster pipeline, real-dependency testing, image traceability, and
zero-downtime deploys.

---

## Part 1: Read the Pipeline (10 min)

```yaml
on: [push, pull_request]
jobs:
  build:   { steps: [ checkout, setup-java@21, "./mvnw -B verify" ] }
  package: { needs: build, steps: [ "build-image :${{ github.sha }}", "docker push ..." ] }
  deploy:  { needs: package, steps: [ "kubectl set image ...:${{ github.sha }}", "kubectl rollout status" ] }
```

```java
@Testcontainers
class PriorAuthIT {
    @Container static PostgreSQLContainer<?> db = new PostgreSQLContainer<>("postgres:16");
    @DynamicPropertySource static void p(DynamicPropertyRegistry r) { r.add("spring.datasource.url", db::getJdbcUrl); }
}
```

**Questions:**

1. The `deploy` job has `needs: package` which `needs: build`. What does that ordering guarantee?
2. Why test against a real Postgres via Testcontainers instead of H2 or a mock?
3. Why tag the image with the commit SHA rather than just `latest`?
4. During the rolling deploy, what must a new pod do before it receives traffic? (Recall M32/M35.)

---

## Part 2: CI vs CD (10 min)

| Term | What it covers | Goal |
|------|----------------|------|
| Continuous Integration | | |
| Continuous Delivery | | |
| Continuous Deployment | | |

---

## Part 3: The Whole Course (10 min)

Match each earlier capability to how it serves the pipeline:

| Capability | Role in CI/CD |
|------------|---------------|
| Externalized config (M07/M35) | |
| Health probes (M32) | |
| Container image (M33) | |
| Kubernetes Deployment (M35) | |

---

## You'll know it worked when:

- [ ] You can describe the stages and their gating
- [ ] You can justify real-dependency testing
- [ ] You can explain SHA tagging and rollback
- [ ] You can connect earlier modules to the pipeline
