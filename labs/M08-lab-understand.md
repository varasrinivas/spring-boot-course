# M08 Lab — Understand It Path

> **Module:** M08 · DevTools & Actuator
> **Track:** Spring Boot Essentials
> **Time:** ~30 minutes

---

## Goal

Understand how Boot makes the Prior Authorization Service fast to develop and ready to operate —
especially how `/actuator/health` aggregates and how to expose endpoints safely.

---

## Part 1: Read the Code (10 min)

```java
@Component
public class PayerApiHealthIndicator implements HealthIndicator {
    private final PayerClient payer;
    public PayerApiHealthIndicator(PayerClient payer) { this.payer = payer; }

    @Override
    public Health health() {
        try {
            payer.ping();
            return Health.up().withDetail("payer", "reachable").build();
        } catch (Exception e) {
            return Health.down(e).withDetail("payer", "unreachable").build();
        }
    }
}
```

**Questions to answer:**

1. Under what key will this indicator appear in `/actuator/health`'s output?
2. The database is UP, disk is UP, but `payer.ping()` throws. What is the **overall**
   `/actuator/health` status, and why?
3. Why might the `payer` detail be hidden when you call `/actuator/health` without
   authentication? Which setting controls that?
4. Which health **group** should this indicator belong to so Kubernetes stops routing traffic
   (but does *not* restart the pod) when the payer is unreachable — liveness or readiness?

---

## Part 2: Exposure & Safety (10 min)

Given:

```yaml
management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
```

| Endpoint | Reachable over HTTP? | Why |
|----------|---------------------|-----|
| `/actuator/health` | | |
| `/actuator/metrics` | | |
| `/actuator/env` | | |
| `/actuator/beans` | | |

Why is `/actuator/env` dangerous to expose publicly?

---

## Part 3: Predict & Verify (10 min)

| Question | Your Answer |
|----------|-------------|
| You add `spring-boot-devtools`. Why does it not change your production JAR? | |
| Which endpoint would a Kubernetes **readiness** probe call? | |
| Where do `/actuator/metrics` numbers come from (which library)? | |
| What does `@ReadOperation` map to for a custom `@Endpoint`? | |

---

## You'll know it worked when:

- [ ] You can explain how the overall health status is computed from indicators
- [ ] You can state what is and isn't exposed by default, and how to change it
- [ ] You can map liveness/readiness groups to Kubernetes probes
- [ ] You can explain why DevTools is dev-only
