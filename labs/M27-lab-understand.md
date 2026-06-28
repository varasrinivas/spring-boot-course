# M27 Lab — Understand It Path

> **Module:** M27 · Saga Pattern
> **Track:** Inter-Service Communication
> **Time:** ~30 minutes

---

## Goal

Reason about distributed consistency: where ACID stops, how compensations restore consistency,
and which coordination style fits.

---

## Part 1: Read the Code (10 min)

```java
var ctx = intake.create(cmd);                 // T1
try {
    eligibility.reserve(ctx.authNumber());    // T2
    review.assign(ctx.authNumber());          // T3
} catch (Exception e) {
    eligibility.cancelReservation(ctx.authNumber());  // C2
    intake.markFailed(ctx.authNumber());              // C1
}
```

**Questions:**

1. T2 succeeds but T3 throws. Which compensations run, in what order, and what's the end state?
2. Why is `cancelReservation` a *new action*, not a database rollback?
3. T2 sends a confirmation email that can't be unsent. How do you "compensate" that?
4. Is this saga choreographed or orchestrated? How can you tell?

---

## Part 2: Choreography vs Orchestration (10 min)

| Aspect | Choreography | Orchestration |
|--------|--------------|---------------|
| Where the flow lives | | |
| Coupling | | |
| Visibility/debugging | | |
| Best when | | |

---

## Part 3: Survivability (10 min)

| Question | Your Answer |
|----------|-------------|
| The orchestrator crashes after T2. How does the saga recover? | |
| An event redelivers and `reserve` runs twice. Why must it be idempotent? | |
| T2 never responds. What stops the saga hanging forever? | |
| Which states would your saga state machine include? | |

---

## You'll know it worked when:

- [ ] You can explain why no transaction spans services
- [ ] You can trace forward steps and reverse compensations
- [ ] You can choose choreography vs orchestration
- [ ] You can list what makes a saga survivable
