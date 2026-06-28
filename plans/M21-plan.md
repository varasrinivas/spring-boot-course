# M21 Plan — Monolith to Microservices

**Track:** Microservices Foundations (key: microservices, color: #a78bfa) — START of Track 6
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Why Decompose? Monolith Limits — visual `m21-monolith-limits` (one deployable + pains; monolith-first valid)
2. Bounded Contexts & Decomposition — visual `m21-bounded-contexts` (split by capability)
3. Data Ownership & Shared-Nothing — visual `m21-data-ownership` (own DB vs shared-DB anti-pattern)
4. The Road Ahead — visual `m21-target-arch` (target prior-auth platform; maps Tracks 6-9)

## Coming From Java
Monolith (one JAR, one DB) — default and often right. Microservices trade simplicity for
independent scale/deploy/ownership at the cost of distributed-systems complexity. Spring Cloud
provides the building blocks.

## Code
- target multi-service project structure (intake/review/eligibility/notification + gateway/config/discovery)

## SVG
- monolith-limits 640×270, bounded-contexts 640×280, data-ownership 640×260, target-arch 640×300
