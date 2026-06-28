# Spring Boot & Microservices — Curriculum Map

> **Target audience:** Java developers new to Spring  
> **Domain anchor:** Prior Authorization Service (healthcare: provider → payer approval before service delivery)  
> **Total modules:** 37 (M00 orientation + 36 content modules across 9 tracks)

---

## Track 0 — Orientation (color: #6366f1)

| ID  | Title | Key Concepts |
|-----|-------|--------------|
| M00 | Course Orientation & Setup | Course structure, prerequisites, dev environment, domain intro |

## Track 1 — Spring Core Fundamentals (color: #1e3a5f) ★ NEW

| ID  | Title | Key Concepts |
|-----|-------|--------------|
| M01 | IoC & Dependency Injection | Inversion of Control, @Component, @Autowired, constructor injection, why DI matters |
| M02 | Beans, Scopes & Lifecycle | @Bean, @Configuration, singleton vs prototype, @PostConstruct, @PreDestroy, ApplicationContext |
| M03 | Aspect-Oriented Programming | @Aspect, @Before, @After, @Around, cross-cutting concerns (logging, transactions, security) |
| M04 | Spring MVC Fundamentals | DispatcherServlet, @Controller, @RequestMapping, Model, ViewResolver, request lifecycle |

## Track 2 — Spring Boot Essentials (color: #2b4a7e)

| ID  | Title | Key Concepts |
|-----|-------|--------------|
| M05 | Your First Spring Boot App | start.spring.io, @SpringBootApplication, embedded Tomcat, fat JAR, what Boot adds over core Spring |
| M06 | Auto-Configuration & Starters | spring-boot-starter-*, conditional beans, @EnableAutoConfiguration, how Boot eliminates XML |
| M07 | Configuration & Profiles | application.yml, @Value, @ConfigurationProperties, spring.profiles.active, externalized config |
| M08 | DevTools & Actuator | Live reload, /actuator/health, /actuator/info, custom endpoints, production readiness |

## Track 3 — Building REST APIs (color: #0d9488)

| ID  | Title | Key Concepts |
|-----|-------|--------------|
| M09 | REST Controllers | @RestController vs @Controller, @GetMapping, @PostMapping, @PathVariable, ResponseEntity |
| M10 | Request Validation & Error Handling | @Valid, @NotNull, ConstraintViolation, @ControllerAdvice, ProblemDetail (RFC 7807) |
| M11 | API Documentation | springdoc-openapi, Swagger UI, @Operation, @Schema annotations |
| M12 | Pagination, Filtering & HATEOAS | Pageable, Sort, Specification, Spring HATEOAS, RepresentationModel |

## Track 4 — Data Access with Spring Data JPA (color: #d97706)

| ID  | Title | Key Concepts |
|-----|-------|--------------|
| M13 | Entities & Repositories | @Entity, @Id, @GeneratedValue, JpaRepository, derived query methods, H2 → PostgreSQL |
| M14 | Custom Queries & Specifications | @Query, JPQL, native queries, Criteria API, JpaSpecificationExecutor |
| M15 | Transactions & Caching | @Transactional, propagation levels, isolation, @Cacheable, CacheManager |
| M16 | Database Migrations | Flyway, migration scripts (V1__create_filings.sql), schema versioning, repeatable migrations |

## Track 5 — Spring Security (color: #dc2626)

| ID  | Title | Key Concepts |
|-----|-------|--------------|
| M17 | Security Fundamentals | SecurityFilterChain, UserDetailsService, PasswordEncoder, CORS, filter chain order |
| M18 | JWT Authentication | JJWT, token generation/validation, OncePerRequestFilter, stateless sessions |
| M19 | OAuth2 Resource Server | spring-boot-starter-oauth2-resource-server, JWT decoder, scopes, resource server config |
| M20 | Method-Level Security | @PreAuthorize, @Secured, SpEL expressions, RBAC patterns, testing secured endpoints |

## Track 6 — Microservices Foundations (color: #7c3aed)

| ID  | Title | Key Concepts |
|-----|-------|--------------|
| M21 | Monolith to Microservices | Bounded contexts, decomposition strategies, data ownership, shared-nothing |
| M22 | Centralized Configuration | Spring Cloud Config Server, Git-backed config, @RefreshScope, config encryption |
| M23 | Service Discovery | Eureka Server, @EnableDiscoveryClient, client-side load balancing, health checks |
| M24 | API Gateway | Spring Cloud Gateway, route predicates, filters, rate limiting, path rewriting |

## Track 7 — Inter-Service Communication (color: #0891b2)

| ID  | Title | Key Concepts |
|-----|-------|--------------|
| M25 | Synchronous Communication | RestClient (Boot 3.2+), WebClient, @FeignClient, error handling, timeouts |
| M26 | Event-Driven Messaging | Spring for Apache Kafka, @KafkaListener, producer/consumer, event schemas |
| M27 | Saga Pattern | Choreography vs orchestration, compensating transactions, state machines |
| M28 | Event Sourcing & CQRS | Event store concepts, command/query separation, read model projections |

## Track 8 — Resilience & Observability (color: #be185d)

| ID  | Title | Key Concepts |
|-----|-------|--------------|
| M29 | Circuit Breakers & Retry | Resilience4j, @CircuitBreaker, @Retry, @RateLimiter, fallback methods |
| M30 | Distributed Tracing | Micrometer Tracing, Brave/OpenTelemetry, Zipkin, trace/span propagation |
| M31 | Centralized Logging | Structured JSON logging, Logback MDC, correlation IDs, ELK stack |
| M32 | Health Checks & Monitoring | Custom HealthIndicator, Prometheus metrics, Grafana dashboards |

## Track 9 — Containerization & Deployment (color: #059669)

| ID  | Title | Key Concepts |
|-----|-------|--------------|
| M33 | Docker for Spring Boot | Multi-stage Dockerfile, Cloud Native Buildpacks, Jib, layered JARs |
| M34 | Docker Compose | Multi-service orchestration, networks, volumes, depends_on, healthcheck |
| M35 | Kubernetes Essentials | Pod, Service, Deployment, ConfigMap, Secret, readiness/liveness probes |
| M36 | CI/CD Pipeline | GitHub Actions, Testcontainers, image push, K8s rolling updates |

---

## Course Progression Logic

```
Track 1: Spring Core          "What is Spring? How does DI/IoC/AOP work?"
    ↓
Track 2: Spring Boot          "How does Boot automate all that wiring?"
    ↓
Track 3: REST APIs            "Let's build an API on top of Boot"
    ↓
Track 4: JPA Data Access      "Let's persist data behind that API"
    ↓
Track 5: Security             "Let's lock it down"
    ↓                         ─── MONOLITH COMPLETE ───
Track 6: Microservices        "Let's decompose it into services"
    ↓
Track 7: Communication        "How do services talk to each other?"
    ↓
Track 8: Resilience           "How do we keep it running?"
    ↓
Track 9: Deployment           "How do we ship it?"
```

## Cross-Cutting Themes

- **Prior-Auth Domain Context:** Every code example uses the Prior Authorization Service domain
- **Coming From Java:** Callouts comparing pure-Java approach vs Spring-managed approach
- **Spring Core → Boot Bridge:** Track 2 explicitly references Track 1 concepts to show what Boot automates
- **AI-Assisted Development:** "Build It with AI" lab path uses Claude Code for every module
- **Production Mindset:** Logging, error handling, testing woven into each module
