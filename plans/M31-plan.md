# M31 Plan — Centralized Logging

**Track:** Resilience & Observability (key: resilience, color: #f472b6)
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Why Centralized Logging — visual `m31-centralized`
2. Structured (JSON) Logging — visual `m31-structured`
3. Correlation: MDC & Trace IDs — visual `m31-mdc`
4. The Log Pipeline: Aggregation & Search — visual `m31-elk`

## Coming From Java
Tail per-server files, grep plain text, no cross-instance search, logs lost when containers die.
Centralized+structured: JSON shipped to indexed store, query any field, correlate by traceId.

## Code
- logback JSON encoder config
- MDC.put(authNumber) + trace IDs auto from M30

## SVG
- centralized 640×250, structured 640×250, mdc 640×260, elk 640×260
