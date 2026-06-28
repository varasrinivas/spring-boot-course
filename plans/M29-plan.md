# M29 Plan — Circuit Breakers & Retry

**Track:** Resilience & Observability (key: resilience, color: #f472b6) — START of Track 8
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Resilience Patterns for Remote Calls — visual `m29-patterns` (Resilience4j overview)
2. Circuit Breaker (CLOSED/OPEN/HALF_OPEN) — visual `m29-circuit-states`
3. Retry, Rate Limiter, Time Limiter — visual `m29-retry-others`
4. Fallbacks & Graceful Degradation — visual `m29-fallback`

## Coming From Java
Naive calls cascade (M25); hand-rolled retry hammers a down service. Resilience4j: declarative.

## Code
- @CircuitBreaker(fallbackMethod) + fallback
- @Retry + @RateLimiter

## SVG
- patterns 640×260, circuit-states 640×270, retry-others 640×260, fallback 640×250
