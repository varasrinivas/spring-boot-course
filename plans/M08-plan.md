# M08 Plan — DevTools & Actuator

**Track:** Spring Boot Essentials (key: boot, color: #5e86c7) — LAST of Track 2
**Level:** Foundational
**Status:** ✅ BUILT

## Concepts

1. **Spring Boot DevTools: Faster Inner Loop**
   - Visual: `m08-devtools` — edit → auto-restart → LiveReload cycle; dev-only (optional=true)
   - Code: devtools pom dependency with optional=true
   - Key point: tightens the dev loop; excluded from the production JAR

2. **Actuator: Production-Ready Endpoints**
   - Visual: `m08-actuator-endpoints` — /actuator hub with endpoint spokes; exposure control
   - Code: management.endpoints.web.exposure.include yaml
   - Key point: standard ops surface; expose only what you intend over HTTP

3. **Health Checks: /actuator/health & Indicators**
   - Visual: `m08-health` — indicators (db, disk, custom payerApi) aggregate → overall status;
     liveness/readiness groups → k8s probes
   - Code: a custom `PayerApiHealthIndicator`
   - Key point: overall = worst indicator; groups feed Kubernetes probes (Track 9)

4. **Metrics, Info & Custom Endpoints**
   - Visual: `m08-metrics-info` — meters → Micrometer → /metrics + /prometheus → monitoring;
     /info + custom @Endpoint
   - Code: a custom `@Endpoint` priorauth-stats
   - Key point: Micrometer metrics + custom endpoints; on-ramp to Track 8 observability

## Coming From Java Angle

Pre-Boot: restart the server by hand on every change; hand-write a /health servlet, custom JMX
beans, and manual metric counters; no standard ops surface. Boot: DevTools auto-restart,
Actuator endpoints, Micrometer metrics.

## Code Examples

- devtools pom dependency optional=true (~5 lines)
- exposure include yaml + health show-details (~9 lines)
- custom HealthIndicator (~12 lines)
- custom @Endpoint priorauth-stats (~12 lines)

## SVG Diagrams

- devtools: 640×260, edit→restart→livereload loop
- actuator-endpoints: 640×300, /actuator hub + endpoint spokes
- health: 640×280, indicators aggregate to overall status + probe groups
- metrics-info: 640×260, meters→Micrometer→monitoring + info + custom endpoint
