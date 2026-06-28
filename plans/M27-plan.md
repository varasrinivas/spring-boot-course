# M27 Plan — Saga Pattern

**Track:** Inter-Service Communication (key: communication, color: #22d3ee)
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. The Distributed Transaction Problem — visual `m27-no-2pc` (no ACID across services)
2. The Saga: Sequence + Compensations — visual `m27-saga-compensation`
3. Choreography vs Orchestration — visual `m27-choreo-vs-orch`
4. Implementing Sagas: State & Idempotency — visual `m27-saga-state` (state machine)

## Coming From Java
Monolith one @Transactional across tables; naive distributed code leaves partial state.
Saga: local steps + compensations, eventual consistency, no global lock.

## Code
- orchestrated SubmitPriorAuthSaga (steps + compensations in catch)

## SVG
- no-2pc 640×250, saga-compensation 640×260, choreo-vs-orch 640×270, saga-state 640×250
