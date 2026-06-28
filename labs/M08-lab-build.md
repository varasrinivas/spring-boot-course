# M08 Lab — Build It with AI Path

> **Module:** M08 · DevTools & Actuator
> **Track:** Spring Boot Essentials
> **Time:** ~45 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Make the Prior Authorization Service observable and pleasant to develop: enable DevTools, expose
Actuator deliberately, write a custom health indicator, and add a custom endpoint and metric.
Claude Code does the wiring; you verify each endpoint with real calls.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: DevTools + Expose Actuator (10 min)

Ask Claude Code:

> "Add `spring-boot-devtools` (optional) and `spring-boot-starter-actuator`. Configure
> `application.yml` to expose `health,info,metrics,prometheus` and set health `show-details` to
> `always` for local dev. Add build info to `/actuator/info`."

Verify:

```powershell
curl http://localhost:8080/actuator/health
curl http://localhost:8080/actuator/info
curl http://localhost:8080/actuator | ConvertFrom-Json
```

**Review:** Is `/actuator/env` reachable? Should it be?

---

## Step 2: Custom Health Indicator (10 min)

> "Create a `PayerApiHealthIndicator` (implements `HealthIndicator`) that pings the `PayerClient`
> and reports UP with a `payer: reachable` detail, or DOWN on failure. Then add it to the
> `readiness` health group."

Test both states:

```powershell
curl http://localhost:8080/actuator/health
# then simulate the payer being down (stop the stub / wrong URL) and call again
```

**Your judgment call:** When the payer is down, what is the overall status, and what does the
`readiness` group report? Why readiness and not liveness?

---

## Step 3: A Custom Endpoint + Metric (15 min)

> "Add a custom `@Endpoint(id=\"priorauth-stats\")` with a `@ReadOperation` returning counts of
> prior-auths by status. Also inject a `MeterRegistry` and increment a
> `priorauth.submitted` counter each time a request is submitted. Make sure the endpoint is
> exposed."

Verify:

```powershell
curl http://localhost:8080/actuator/priorauth-stats
curl http://localhost:8080/actuator/metrics/priorauth.submitted
```

---

## Step 4: Reflect (10 min)

- [ ] Which endpoints did you expose, and which did you deliberately keep internal? Why?
- [ ] What's the difference between your `readiness` indicator and a `liveness` one,
      operationally?
- [ ] How will the `priorauth.submitted` metric reach a dashboard in Track 8?

---

## You'll know it worked when:

- [ ] DevTools restarts the app automatically on a code change
- [ ] `/actuator/health` shows your custom `payerApi` indicator and reacts to its state
- [ ] `/actuator/priorauth-stats` returns live counts by status
- [ ] `priorauth.submitted` appears under `/actuator/metrics`
