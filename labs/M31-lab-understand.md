# M31 Lab — Understand It Path

> **Module:** M31 · Centralized Logging
> **Track:** Resilience & Observability
> **Time:** ~30 minutes

---

## Goal

Understand structured logging, the MDC, and the log pipeline — and how trace IDs link logs to
traces.

---

## Part 1: Read the Code (10 min)

```java
MDC.put("authNumber", request.authNumber());
try {
    log.info("validating prior-auth");   // + traceId/spanId from M30 (auto)
} finally {
    MDC.remove("authNumber");
}
```

Output: `{"level":"INFO","service":"review","traceId":"4bf92f","authNumber":"PA-2026-000123","message":"validating prior-auth"}`

**Questions:**

1. You never passed `authNumber` to `log.info`. How did it end up in the JSON line?
2. Where did `traceId` come from?
3. Why is the `finally` MDC.remove important on a reused thread?
4. To see every service's logs for one request, which field do you filter on? For one
   authorization's whole history?

---

## Part 2: Why Structured (10 min)

| Task | Plain text | JSON |
|------|-----------|------|
| "all WARN from review" | | |
| "everything for traceId X" | | |
| count errors per service | | |

---

## Part 3: The Pipeline (10 min)

| Stage | Example tool | Job |
|-------|-------------|-----|
| emit | | |
| ship | | |
| store/index | | |
| search/alert | | |

How do logs (M31) and traces (M30) connect?

---

## You'll know it worked when:

- [ ] You can explain MDC-based correlation
- [ ] You can argue JSON over plain text for queryability
- [ ] You can name the pipeline stages
- [ ] You can pivot from a trace to its logs via traceId
