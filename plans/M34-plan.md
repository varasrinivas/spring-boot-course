# M34 Plan — Docker Compose

**Track:** Containerization & Deployment (key: deployment, color: #34d399)
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Running the Whole Stack Locally — visual `m34-stack`
2. The Compose File: Services, Networks, Volumes — visual `m34-compose-anatomy`
3. Dependencies & Health: depends_on, healthcheck — visual `m34-depends-health`
4. Compose's Place: Dev/Test, Not Prod — visual `m34-compose-vs-k8s`

## Coming From Java
Run each container manually, remember ports/env/links, fragile start scripts.
Compose: one declarative file, one command, reproducible local stack.

## Code
- docker-compose.yml services + network + volumes
- healthcheck + depends_on condition: service_healthy

## SVG
- stack 640×250, compose-anatomy 640×270, depends-health 640×250, compose-vs-k8s 640×250
