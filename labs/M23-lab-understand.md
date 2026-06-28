# M23 Lab — Understand It Path

> **Module:** M23 · Service Discovery
> **Track:** Microservices Foundations
> **Time:** ~30 minutes

---

## Goal

Understand how services find each other by name and balance across instances as the fleet changes.

---

## Part 1: Read the Code (10 min)

```java
@Bean @LoadBalanced
RestClient.Builder loadBalanced() { return RestClient.builder(); }

Eligibility e = restClient.get()
    .uri("http://eligibility-service/api/eligibility/{member}", memberId)
    .retrieve().body(Eligibility.class);
```

**Questions:**

1. `eligibility-service` isn't a DNS host. How does the request actually reach an instance?
2. There are three eligibility instances. Which one serves this call, and who decides?
3. A fourth instance starts up. What must change in this code for traffic to reach it? (Trick.)
4. What does `@EnableEurekaServer` run, and what do clients send it periodically?

---

## Part 2: Why Not Just Config? (10 min)

| Question | Answer |
|----------|--------|
| Why can't you just put the eligibility URL in the Config Server (M22)? | |
| What does a registry track that static config cannot? | |
| What removes a crashed instance from rotation? | |
| Client-side vs server-side load balancing — what's the difference here? | |

---

## Part 3: Heartbeats (10 min)

1. An instance's process is killed. Walk through how the registry and callers find out.
2. How do heartbeat interval and lease expiry trade off detection speed vs chatter?
3. How does this relate to the Actuator health from M08?

---

## You'll know it worked when:

- [ ] You can explain name → instance resolution
- [ ] You can say who load-balances and where
- [ ] You can describe lease expiry / eviction
- [ ] You can connect discovery health to Actuator
