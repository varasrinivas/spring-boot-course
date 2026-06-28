# M28 Plan — Event Sourcing & CQRS

**Track:** Inter-Service Communication (key: communication, color: #22d3ee) — LAST of Track 7
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. CQRS: Separate Reads from Writes — visual `m28-cqrs`
2. Event Sourcing: Store Events, Not State — visual `m28-event-sourcing`
3. Read Model Projections — visual `m28-projections`
4. Trade-offs & When to Use — visual `m28-tradeoffs`

## Coming From Java
CRUD overwrites history (UPDATE loses the path); one model for read+write.
ES+CQRS: append events, derive state, tailored read models.

## Code
- command/event records + state = fold(events)
- @EventHandler projection building a read model

## SVG
- cqrs 640×260, event-sourcing 640×260, projections 640×260, tradeoffs 640×260
