# M31 Lab — Build It with AI Path

> **Module:** M31 · Centralized Logging
> **Track:** Resilience & Observability
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21, Docker

---

## Goal

Emit structured JSON logs enriched with the MDC across the prior-auth services and search them in
one place by `authNumber` and `traceId`.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: JSON Logs (15 min)

Ask Claude Code:

> "Switch `prior-auth-review` and `eligibility-service` to JSON logging (Logstash Logback Encoder
> or Boot structured logging). Confirm a log line is valid JSON with level, service, message, and
> the `traceId`/`spanId` from Micrometer Tracing (M30)."

---

## Step 2: MDC Business Keys (15 min)

> "Add a filter/interceptor that puts `authNumber` (and the authenticated user) into the MDC at
> the start of a request and clears it at the end. Confirm every log line during that request
> includes `authNumber` automatically."

```powershell
curl -X PATCH http://localhost:8080/api/prior-auths/PA-1/decision -d '{"decision":"APPROVED"}'
# inspect the JSON logs — authNumber present on each line
```

**Review:** Is the MDC cleared in a `finally`?

---

## Step 3: Centralize & Search (15 min)

> "Run a log stack in Docker (Loki + Grafana, or ELK). Ship both services' JSON logs to it. Then
> search by `authNumber=PA-1` and by a `traceId`, and confirm you get lines from BOTH services."

**Your judgment call:** Take a `traceId` from a Zipkin trace (M30) and paste it into the log
search. Do you get the matching logs? That pivot is the whole point.

---

## Step 4: Reflect (5 min)

- [ ] How would you have investigated this incident without centralization?
- [ ] Which fields proved most useful to filter on?
- [ ] How do logs + traces + (coming) metrics together make the system observable?

---

## You'll know it worked when:

- [ ] Services emit valid structured JSON logs with trace IDs
- [ ] `authNumber` appears on every line of a request via the MDC
- [ ] A central search returns one request's logs across services
- [ ] A Zipkin trace ID finds the matching logs
