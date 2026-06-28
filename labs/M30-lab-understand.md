# M30 Lab — Understand It Path

> **Module:** M30 · Distributed Tracing
> **Track:** Resilience & Observability
> **Time:** ~30 minutes

---

## Goal

Understand traces, spans, propagation, and how a Zipkin waterfall pinpoints latency.

---

## Part 1: Read the Trace (10 min)

A prior-auth submission produces this trace (total 812ms):

```
gateway ───────────────────────────────── 812ms
  intake ──────────────────────────────── 760ms
    review ────────────────────────────── 690ms
      eligibility ───────────────────── 610ms   ← ?
      kafka publish ─ 14ms
```

**Questions:**

1. Which span is the bottleneck, and how do you know at a glance?
2. All these spans share one identifier. What is it, and how did each service get it?
3. What carries the trace context from `review` to `eligibility`? From `review` to Kafka?
4. If `eligibility` did NOT propagate context, what would the trace look like?

---

## Part 2: Concepts (10 min)

| Term | One-line meaning |
|------|------------------|
| span | |
| trace | |
| trace ID | |
| sampling | |

---

## Part 3: Tooling (10 min)

| Question | Your Answer |
|----------|-------------|
| What does Micrometer Tracing instrument automatically? | |
| Where do trace/span IDs show up besides the backend? | |
| Name two tracing backends that render the waterfall. | |
| How do you jump from a user-reported slow request to its exact trace? | |

---

## You'll know it worked when:

- [ ] You can read a waterfall and name the bottleneck
- [ ] You can explain trace context propagation
- [ ] You can list what Micrometer auto-instruments
- [ ] You can connect trace IDs to logs (M31)
