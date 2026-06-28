# M25 Plan — Synchronous Communication

**Track:** Inter-Service Communication (key: communication, color: #22d3ee) — START of Track 7
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Synchronous Calls Between Services — visual `m25-sync-call` (review → eligibility, caller waits)
2. RestClient: Modern Sync Client — visual `m25-restclient` (fluent + lb + typed body; WebClient note)
3. Declarative Clients: @HttpExchange / @FeignClient — visual `m25-declarative`
4. Resilient Calls: Timeouts & Errors — visual `m25-timeouts`

## Coming From Java
RestTemplate (maintenance) / HttpURLConnection, manual JSON, no discovery, forgotten timeouts.
RestClient fluent + discovery + typed; declarative interfaces remove boilerplate.

## Code
- @LoadBalanced RestClient call by service name
- @HttpExchange EligibilityClient interface
- connect/read timeouts + error handling

## SVG
- sync-call 640×250, restclient 640×260, declarative 640×250, timeouts 640×260
