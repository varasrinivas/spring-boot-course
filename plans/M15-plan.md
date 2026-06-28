# M15 Plan — Transactions & Caching

**Track:** Data Access with JPA (key: jpa, color: #f59e0b)
**Level:** Intermediate
**Status:** ✅ BUILT

## Concepts
1. @Transactional: Atomic Units of Work — visual `m15-transaction` (begin→ops→commit / rollback)
2. Propagation — visual `m15-propagation` (REQUIRED joins vs REQUIRES_NEW new tx)
3. Isolation & Pitfalls — visual `m15-isolation` (levels vs anomalies grid; readOnly; proxy self-invocation)
4. Caching — visual `m15-cache` (@Cacheable hit/miss; @CacheEvict; CacheManager)

## Coming From Java
Manual JDBC tx (setAutoCommit(false)/commit/rollback/finally, leak-prone); hand-rolled cache maps.
Spring: declarative @Transactional and @Cacheable.

## Code
- @Transactional decide() with two writes
- propagation REQUIRED vs REQUIRES_NEW
- readOnly + isolation
- @Cacheable policyFor + @CacheEvict

## SVG
- transaction 640×250, propagation 640×270, isolation 640×280, cache 640×260
