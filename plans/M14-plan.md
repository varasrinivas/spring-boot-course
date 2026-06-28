# M14 Plan — Custom Queries & Specifications

**Track:** Data Access with JPA (key: jpa, color: #f59e0b)
**Level:** Intermediate
**Status:** ✅ BUILT

## Concepts

1. **@Query: JPQL Queries**
   - Visual: `m14-jpql` — JPQL over entities/fields → SQL over tables/columns
   - Code: @Query JPQL with @Param
   - Key point: JPQL targets entities (portable); use when method names get unwieldy

2. **Native Queries & Projections**
   - Visual: `m14-native-projection` — native SQL → interface projection → narrow shape
   - Code: @Query(nativeQuery=true) aggregate + projection interface
   - Key point: native SQL for DB-specific power; projections shape/limit the result

3. **The Criteria API: Type-Safe Dynamic Queries**
   - Visual: `m14-criteria` — CriteriaBuilder + Root + Predicate → CriteriaQuery → SQL
   - Code: a CriteriaQuery snippet
   - Key point: verbose but type-safe and dynamic — the engine under Specifications

4. **Specifications: Composable Dynamic Filters**
   - Visual: `m14-specifications` — optional spec predicates compose into a dynamic WHERE
   - Code: Specification methods + JpaSpecificationExecutor + where().and()
   - Key point: each filter is a reusable predicate; null = skipped (completes M12)

## Coming From Java Angle

Raw JDBC: dynamic SQL by string concatenation (injection-prone), or a sprawl of query methods.
Spring: @Query for fixed complex queries, Criteria/Specifications for type-safe dynamic ones,
projections for shaping.

## Code Examples

- @Query JPQL with @Param (~4 lines)
- native query + projection interface (~10 lines)
- Criteria API snippet (~6 lines)
- Specifications + JpaSpecificationExecutor (~12 lines)

## SVG Diagrams

- jpql: 640×250, JPQL → SQL translation
- native-projection: 640×260, native SQL → projection
- criteria: 640×260, criteria building blocks
- specifications: 640×270, composable optional predicates → WHERE
