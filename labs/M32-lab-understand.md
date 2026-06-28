# M32 Lab — Understand It Path

> **Module:** M32 · Health Checks & Monitoring
> **Track:** Resilience & Observability
> **Time:** ~30 minutes

---

## Goal

Understand liveness vs readiness, Prometheus metrics, the golden signals, and alerting on SLOs.

---

## Part 1: Read the Code (10 min)

```java
class PayerHealthIndicator implements HealthIndicator {
    public Health health() { return payer.isReachable() ? Health.up().build() : Health.down().build(); }
}
// management.endpoint.health.group.readiness.include: readinessState, payerHealthIndicator

Counter submitted = reg.counter("priorauth.submitted");
Timer decisionTimer = reg.timer("priorauth.decision.latency");
```

**Questions:**

1. The payer is unreachable. Should this instance be *restarted* or *removed from traffic*? Which
   probe, and why is it in the readiness (not liveness) group?
2. Prometheus gets metrics by pull or push? Where from?
3. Counter vs Gauge vs Timer — give a prior-auth example of each.
4. Which of the four golden signals would `priorauth.decision.latency` feed?

---

## Part 2: Golden Signals (10 min)

| Signal | A prior-auth metric |
|--------|---------------------|
| Latency | |
| Traffic | |
| Errors | |
| Saturation | |

---

## Part 3: Alerting & Observability (10 min)

| Question | Your Answer |
|----------|-------------|
| Why alert on symptoms (errors/latency) not causes? | |
| What is an SLO and an error budget? | |
| A metric alert fires. How do traces (M30) and logs (M31) help next? | |
| Why is metrics the "always-on pulse" vs per-request traces? | |

---

## You'll know it worked when:

- [ ] You can distinguish liveness from readiness and their actions
- [ ] You can place a metric into a golden signal
- [ ] You can explain the pull-based Prometheus model
- [ ] You can describe the metrics→traces→logs drilldown
