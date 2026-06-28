# M00 Plan — Course Orientation & Setup

**Track:** Orientation (color: #6366f1)  
**Level:** Foundational  
**Status:** ✅ BUILT

## Concepts

1. **The 9-Track Learning Path**
   - Visual: `m00-track-overview` — 3-phase SVG: Phase 1 Spring Core, Phase 2 Monolith (Boot+REST+JPA+Security), Phase 3 Microservices
   - Key point: core-first approach — learn what Spring does before Boot automates it

2. **The Prior Authorization Domain**
   - Visual: `m00-domain-model` — entity relationship diagram (PriorAuthRequest, Patient, Provider, RequestedService)
   - Key point: entities map to REST resources, JPA entities, Kafka events, and service boundaries

3. **Development Environment Setup**
   - Visual: `m00-dev-stack` — four-card layout (JDK 21, IDE, Docker, Claude Code)
   - Key point: winget install commands for Windows

## Coming From Java Angle

Pure Java: manual dependency wiring, XML configs, WAR deployments, JDBC boilerplate  
Spring Core (Track 1): understand IoC/DI/AOP mechanics  
Spring Boot (Track 2): see what Boot automates on top of Core

## Code Examples

None — M00 is conceptual orientation only. Code starts in M01.

## SVG Diagrams

- Track overview: 720×440, three-phase layout with Spring Core detail box
- Domain model: 640×280, ER diagram style
- Dev stack: 600×200, horizontal card layout
