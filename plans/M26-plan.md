# M26 Plan — Event-Driven Messaging

**Track:** Inter-Service Communication (key: communication, color: #22d3ee)
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Async Messaging vs Sync — visual `m26-async-vs-sync`
2. Kafka: Topics, Partitions, Consumer Groups — visual `m26-kafka-topics`
3. Producing & Consuming in Spring — visual `m26-produce-consume` (KafkaTemplate + @KafkaListener)
4. Event Schemas & Evolution — visual `m26-event-schema`

## Coming From Java
Sync chains (tight coupling/cascades) or DIY queues. Kafka+Spring: durable log, independent consumers.

## Code
- DecisionPublisher KafkaTemplate.send("prior-auth.decided", key, event)
- @KafkaListener notification consumer
- PriorAuthDecided event record + schema evolution

## SVG
- async-vs-sync 640×260, kafka-topics 640×270, produce-consume 640×250, event-schema 640×250
