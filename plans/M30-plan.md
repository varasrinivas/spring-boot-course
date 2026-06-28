# M30 Plan — Distributed Tracing

**Track:** Resilience & Observability (key: resilience, color: #f472b6)
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. The Distributed Debugging Problem — visual `m30-debug-problem`
2. Traces, Spans & Context Propagation — visual `m30-trace-spans`
3. Micrometer Tracing in Spring Boot — visual `m30-micrometer`
4. Visualizing with Zipkin/Tempo — visual `m30-zipkin` (waterfall)

## Coming From Java
Grep separate logs, correlate timestamps by hand, guess which hop was slow.
Tracing: one trace ID follows the request; timeline shows per-span latency + errors.

## Code
- micrometer-tracing-bridge + zipkin reporter deps
- propagation note (traceparent/B3), trace/span IDs in logs (MDC)

## SVG
- debug-problem 640×250, trace-spans 640×270, micrometer 640×250, zipkin 640×270
