# M32 Plan — Health Checks & Monitoring

**Track:** Resilience & Observability (key: resilience, color: #f472b6) — LAST of Track 8
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Health Checks for Orchestration — visual `m32-probes` (liveness/readiness, builds on M08)
2. Metrics with Micrometer & Prometheus — visual `m32-prometheus`
3. Four Golden Signals & Dashboards — visual `m32-golden-signals`
4. Alerting & SLOs — visual `m32-alerting` (observability triad)

## Coming From Java
Ad hoc health, hand-rolled counters, no dashboards, users report outages.
Micrometer+Prometheus+Grafana: standard probes, vendor-neutral metrics, dashboards, alerts.

## Code
- custom PayerHealthIndicator in readiness group
- MeterRegistry counter/timer (priorauth.submitted) → /actuator/prometheus

## SVG
- probes 640×260, prometheus 640×250, golden-signals 640×270, alerting 640×250
