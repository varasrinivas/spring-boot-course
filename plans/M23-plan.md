# M23 Plan — Service Discovery

**Track:** Microservices Foundations (key: microservices, color: #a78bfa)
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. The Discovery Problem — visual `m23-discovery-problem` (hardcoded URLs vs dynamic instances)
2. Eureka: Service Registry — visual `m23-eureka-registry` (register → registry → query by name)
3. Discovery + Client-Side Load Balancing — visual `m23-client-lb` (resolve name → instances → LB)
4. Health, Heartbeats & Self-Healing — visual `m23-heartbeat` (renew/evict)

## Coming From Java
Hardcoded host:port or ops-managed LB updated by hand; brittle with autoscaling/containers.
Discovery: self-register, resolve by name, LB automatic.

## Code
- @EnableEurekaServer + client eureka config
- @LoadBalanced RestClient calling http://eligibility-service/...

## SVG
- discovery-problem 640×260, eureka-registry 640×270, client-lb 640×260, heartbeat 640×250
