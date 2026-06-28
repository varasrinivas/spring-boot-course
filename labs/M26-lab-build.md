# M26 Lab — Build It with AI Path

> **Module:** M26 · Event-Driven Messaging
> **Track:** Inter-Service Communication
> **Time:** ~55 minutes
> **Requires:** Claude Code, JDK 21, Docker (Kafka)

---

## Goal

Publish a `PriorAuthDecided` event from review and consume it in notification — fully decoupled —
with Kafka.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: Kafka + Producer (15 min)

Ask Claude Code:

> "Add a `docker-compose` Kafka. In `prior-auth-review`, add `spring-kafka`, a `PriorAuthDecided`
> record, and a `DecisionPublisher` that sends to `prior-auth.decided` keyed by `authNumber`
> after a decision. Use JSON serialization."

```powershell
curl -X PATCH http://localhost:8080/api/prior-auths/PA-1/decision -d '{"decision":"APPROVED"}'
# then inspect the topic
```

---

## Step 2: Consumer (15 min)

> "In `notification-service`, add a `@KafkaListener(topics=\"prior-auth.decided\",
> groupId=\"notification\")` that logs 'emailing provider for {authNumber}: {decision}'. Run it
> and confirm it reacts to the decision — without review calling it directly."

**Review:** Stop `notification-service`, make two decisions, restart it — confirm it processes the
missed events from the offset.

---

## Step 3: Fan-out & Idempotency (15 min)

> "Add a second consumer group `analytics` that counts decisions. Then make the notification
> consumer idempotent (dedupe by `authNumber` + decision) and show that a redelivered event isn't
> emailed twice."

**Your judgment call:** Did adding `analytics` require any change to `review`? (It shouldn't.)

---

## Step 4: Reflect (10 min)

- [ ] How is the review→notification coupling different now vs a sync call (M25)?
- [ ] What did keying by `authNumber` buy you?
- [ ] How would you evolve `PriorAuthDecided` without breaking the analytics consumer?

---

## You'll know it worked when:

- [ ] A decision publishes an event; notification reacts independently
- [ ] Restarting notification replays missed events from its offset
- [ ] A second consumer group works with no producer changes
- [ ] A duplicate delivery does not double-send the notification
