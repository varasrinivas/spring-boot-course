# M26 Lab — Understand It Path

> **Module:** M26 · Event-Driven Messaging
> **Track:** Inter-Service Communication
> **Time:** ~30 minutes

---

## Goal

Understand event-driven decoupling, Kafka's model, and safe event evolution for the prior-auth
platform.

---

## Part 1: Read the Code (10 min)

```java
kafka.send("prior-auth.decided", event.authNumber(), event);   // producer

@KafkaListener(topics = "prior-auth.decided", groupId = "notification")
public void on(PriorAuthDecided event) { notifier.emailProvider(event); }
```

**Questions:**

1. Why key the event by `authNumber`? What does that guarantee about ordering?
2. `notification-service` is down for an hour, then restarts. Does it lose the decisions made
   meanwhile? Why not?
3. You add an `analytics` consumer group. Does `review` change? Does `notification` see fewer
   events?
4. The same event is delivered twice. Why can that happen, and what must the consumer do?

---

## Part 2: Sync vs Event (10 min)

| Interaction | Sync call or Event? | Why |
|-------------|--------------------|-----|
| Review needs eligibility to decide | | |
| Notify provider of a decision | | |
| Update an analytics read model | | |

---

## Part 3: Schema Evolution (10 min)

For `PriorAuthDecided`, mark each change safe or unsafe for existing consumers:

| Change | Safe? |
|--------|-------|
| Add optional `denialReason` | |
| Rename `reviewer` → `decidedBy` | |
| Remove `decidedAt` | |
| Add `priority` with a default | |

---

## You'll know it worked when:

- [ ] You can explain temporal decoupling and eventual consistency
- [ ] You can describe topics, partitions, consumer groups, offsets
- [ ] You can choose sync vs event per interaction
- [ ] You can classify schema changes as compatible or not
