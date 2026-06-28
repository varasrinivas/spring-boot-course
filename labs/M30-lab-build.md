# M30 Lab — Build It with AI Path

> **Module:** M30 · Distributed Tracing
> **Track:** Resilience & Observability
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21, Docker (Zipkin)

---

## Goal

Add distributed tracing across the prior-auth services and view a real trace of one submission in
Zipkin.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: Add Tracing (15 min)

Ask Claude Code:

> "Run Zipkin in Docker. Add `micrometer-tracing-bridge-brave` and `zipkin-reporter-brave` to the
> gateway, intake, review, and eligibility services. Set sampling probability 1.0 and include
> `[%X{traceId},%X{spanId}]` in the log pattern."

```powershell
docker run -d -p 9411:9411 openzipkin/zipkin
```

---

## Step 2: Generate & View a Trace (20 min)

> "Make a prior-auth submission flow through gateway → intake → review → eligibility. Then open
> Zipkin and find the trace."

```powershell
curl -X POST http://localhost:8080/api/prior-auths -d '{...}'
Start-Process "http://localhost:9411"
```

**Review:** Do you see one trace with nested spans for each service? Are the trace IDs in the
service logs the same one Zipkin shows?

---

## Step 3: Find a Bottleneck (15 min)

> "Add an artificial 500ms delay in `eligibility`. Submit again and use the Zipkin waterfall to
> identify eligibility as the slow span. Then add a custom span around a specific business step in
> review and confirm it appears."

**Your judgment call:** Without tracing, how would you have found that 500ms? With it, how long
did it take?

---

## Step 4: Reflect (no code)

- [ ] How did one trace ID tie the whole request together?
- [ ] What would break the trace across a hop?
- [ ] How will the trace IDs in logs help in M31 (centralized logging)?

---

## You'll know it worked when:

- [ ] A submission produces a single multi-service trace in Zipkin
- [ ] Service logs carry the same trace ID as the trace
- [ ] The waterfall pinpoints the injected slow span
- [ ] A custom span appears in the trace
