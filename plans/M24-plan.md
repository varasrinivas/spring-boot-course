# M24 Plan — API Gateway

**Track:** Microservices Foundations (key: microservices, color: #a78bfa) — LAST of Track 6
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Why a Gateway: Single Entry Point — visual `m24-gateway-role`
2. Routes: Predicates & URIs (lb://) — visual `m24-routes`
3. Gateway Filters (pre/post) — visual `m24-filters`
4. Cross-Cutting at the Edge (auth/rate-limit/CORS) — visual `m24-edge-concerns`

## Coming From Java
Clients hardcoding many service URLs; each service re-implementing auth/CORS/rate-limit; or
brittle nginx. Gateway: declarative routes, discovery-integrated, programmable filters.

## Code
- routes yaml (Path/Method predicates → lb://service)
- filters (RewritePath, AddRequestHeader)
- RequestRateLimiter (redis)

## SVG
- gateway-role 640×260, routes 640×270, filters 640×260, edge-concerns 640×260
