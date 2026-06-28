# M13 Plan — Entities & Repositories

**Track:** Data Access with JPA (key: jpa, color: #f59e0b) — START of Track 4
**Level:** Intermediate
**Status:** ✅ BUILT

## Concepts

1. **JPA Entities: Mapping Objects to Tables**
   - Visual: `m13-entity-table` — PriorAuth @Entity fields ↔ prior_auth table columns
   - Code: @Entity/@Table/@Id/@GeneratedValue/@Column/@Enumerated
   - Key point: a class = a table, an instance = a row

2. **Spring Data JpaRepository: CRUD for Free**
   - Visual: `m13-repository` — your interface → Spring-generated proxy → SQL → DB
   - Code: interface PriorAuthRepository extends JpaRepository<PriorAuth, Long>
   - Key point: extend an interface, get save/findById/findAll/paging with no implementation

3. **Derived Query Methods**
   - Visual: `m13-derived-queries` — method name parsed into a WHERE clause
   - Code: findByAuthNumber, findByStatus(Pageable), countByStatus, existsByAuthNumber
   - Key point: the method name IS the query

4. **From H2 to PostgreSQL: Config & Dialect**
   - Visual: `m13-h2-postgres` — same entity/repo, swap datasource per profile
   - Code: application.yml datasource for dev (H2) vs prod (PostgreSQL)
   - Key point: identical JPA code runs on different DBs via config (ties to M07 profiles)

## Coming From Java Angle

Raw JDBC: hand-written SQL, Connection/PreparedStatement/ResultSet, manual column→field mapping,
SQLException handling, resource closing — a boilerplate-heavy DAO per entity. Spring Data JPA:
annotate, extend an interface, queries from method names.

## Code Examples

- @Entity PriorAuth mapping (~14 lines)
- JpaRepository interface (~4 lines)
- derived query methods (~8 lines)
- dev H2 / prod PostgreSQL datasource yaml (~12 lines)

## SVG Diagrams

- entity-table: 640×280, entity fields ↔ table columns
- repository: 640×260, interface → proxy → SQL pipeline
- derived-queries: 640×270, method name → WHERE clause
- h2-postgres: 640×260, same code → H2 (dev) / PostgreSQL (prod)
