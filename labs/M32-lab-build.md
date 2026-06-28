# M32 Lab — Build It with AI Path

> **Module:** M32 · Health Checks & Monitoring
> **Track:** Resilience & Observability
> **Time:** ~55 minutes
> **Requires:** Claude Code, JDK 21, Docker (Prometheus + Grafana)

---

## Goal

Add readiness gating, domain metrics, a Grafana golden-signals dashboard, and one alert for the
prior-auth services.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: Probes (15 min)

Ask Claude Code:

> "In `prior-auth-review`, add a `PayerHealthIndicator` and put it in the readiness group. Expose
> liveness/readiness. Show that when the payer stub is down, `/actuator/health/readiness` is DOWN
> but `/liveness` stays UP."

```powershell
curl http://localhost:8083/actuator/health/readiness
curl http://localhost:8083/actuator/health/liveness
```

---

## Step 2: Metrics + Prometheus (15 min)

> "Add `micrometer-registry-prometheus`. Record a `priorauth.submitted` counter and a
> `priorauth.decision.latency` timer. Run Prometheus in Docker scraping
> `/actuator/prometheus`. Confirm the metrics appear in Prometheus."

```powershell
curl http://localhost:8083/actuator/prometheus | Select-String priorauth
Start-Process "http://localhost:9090"
```

---

## Step 3: Dashboard + Alert (20 min)

> "Run Grafana, add Prometheus as a data source, and build a dashboard with the four golden
> signals (latency p95, request rate, error rate, JVM/CPU saturation) for review. Add an alert:
> error rate > 5% for 5 minutes."

**Your judgment call:** Drive some errors and watch the error panel and the alert. Then take the
trace ID from a failed request and find its logs (M31) — the metrics→traces→logs drilldown.

---

## Step 4: Reflect (5 min)

- [ ] What would the orchestrator do with your readiness signal in Track 9?
- [ ] Which golden signal surfaced a problem first?
- [ ] Write one SLO for the decision endpoint.

---

## You'll know it worked when:

- [ ] Readiness reflects payer availability; liveness doesn't
- [ ] Domain metrics are scraped by Prometheus
- [ ] A Grafana dashboard shows the four golden signals
- [ ] An alert fires on elevated errors, and you can drill to traces/logs
