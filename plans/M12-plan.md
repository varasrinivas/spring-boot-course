# M12 Plan — Pagination, Filtering & HATEOAS

**Track:** Building REST APIs (key: rest, color: #2dd4bf) — LAST of Track 3
**Level:** Intermediate
**Status:** ✅ BUILT

## Concepts

1. **Pagination with Pageable**
   - Visual: `m12-pagination` — request page/size → a Page slice of the full set + metadata
   - Code: controller takes Pageable, returns Page<PriorAuthResponse>
   - Key point: never return everything; Page carries items + total metadata

2. **Sorting & Filtering**
   - Visual: `m12-filter-sort` — ?status=&cptCode=&sort=requestDate,desc → WHERE + ORDER BY
   - Code: filter params + Sort; light Specification (full treatment in M14)
   - Key point: query params drive dynamic predicates and ordering

3. **HATEOAS: Hypermedia Links**
   - Visual: `m12-hateoas` — resource JSON with _links (self, decision, patient)
   - Code: EntityModel + WebMvcLinkBuilder (linkTo/methodOn)
   - Key point: responses carry navigable links (Richardson maturity level 3)

4. **Paged Hypermedia Responses**
   - Visual: `m12-pagedmodel` — _embedded items + page block + _links (first/prev/self/next/last)
   - Code: PagedModel via PagedResourcesAssembler
   - Key point: combine paging + hypermedia for self-describing collections

## Coming From Java Angle

Hand-rolled LIMIT/OFFSET, manual count queries, parsing page params yourself, building links by
string concatenation. Spring: Pageable auto-bound, Page metadata computed, type-safe HATEOAS
link builders.

## Code Examples

- Pageable param + Page return (~6 lines)
- filter params + Specification sketch (~9 lines)
- EntityModel with self + action links (~6 lines)
- PagedModel via assembler (~7 lines)

## SVG Diagrams

- pagination: 640×270, dataset window + Page metadata
- filter-sort: 640×260, query params → WHERE/ORDER BY
- hateoas: 640×280, resource JSON with _links
- pagedmodel: 640×300, _embedded + page + _links nav
