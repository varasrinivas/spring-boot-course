# M21 Lab — Understand It Path

> **Module:** M21 · Monolith to Microservices
> **Track:** Microservices Foundations
> **Time:** ~30 minutes

---

## Goal

Reason about *whether* and *where* to decompose the Prior Authorization monolith — the design
thinking before any code.

---

## Part 1: Should You Split? (10 min)

For each scenario, decide: stay monolith, or decompose — and why.

| Scenario | Decision | Why |
|----------|----------|-----|
| Eligibility checks need 10× the compute of everything else | | |
| One small team, early product, frequent pivots | | |
| Three teams blocked on a shared release pipeline | | |
| You read that microservices are "best practice" | | |

---

## Part 2: Find the Seams (10 min)

The prior-auth monolith has these capabilities. Group them into bounded-context services and
name each:

- accept + validate a submission
- assign and decide (approve/deny)
- look up payer policy and member coverage
- email/notify the provider of a decision

1. How many services, and what are their boundaries?
2. Which split would be *wrong* — give an example of a technical-layer cut.

---

## Part 3: Data & Consistency (10 min)

| Question | Your Answer |
|----------|-------------|
| Why can't Review just read Eligibility's tables directly? | |
| How does Review get eligibility data instead? | |
| What consistency do you give up vs a monolith transaction? | |
| Which later modules help you cope with that (events, Saga)? | |

---

## You'll know it worked when:

- [ ] You can argue both for and against decomposing a given system
- [ ] You can split the domain by capability, not layer
- [ ] You can explain why each service owns its data
- [ ] You can name the consistency trade-off and what manages it
