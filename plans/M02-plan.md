# M02 Plan — Beans, Scopes & Lifecycle

**Track:** Spring Core Fundamentals (color: #6ea3d8)
**Level:** Foundational
**Status:** ✅ BUILT

## Concepts

1. **@Configuration & @Bean: Explicit Bean Definitions**
   - Visual: `m02-config-bean` — two routes to a bean: annotate your own class with
     `@Component`, OR define a `@Bean` factory method for a class you can't annotate
   - Code: `@Configuration PriorAuthConfig` with `@Bean payerClient(...)` and `@Bean clock()`
   - Key point: `@Bean` is for third-party / hand-constructed objects

2. **Bean Scopes: Singleton vs Prototype**
   - Visual: `m02-scopes` — singleton (one shared instance) vs prototype (new each request)
   - Code: stateless `AuthRulesEngine` (singleton) vs stateful `MedicalNecessityCheck`
     (`@Scope("prototype")`)
   - Key point: default singleton must be stateless/thread-safe; prototype for per-use state

3. **The Bean Lifecycle: @PostConstruct & @PreDestroy**
   - Visual: `m02-lifecycle` — timeline: instantiate → inject deps → @PostConstruct →
     in use → @PreDestroy → destroy
   - Code: `AuthPolicyCache` warming on `@PostConstruct`, clearing on `@PreDestroy`
   - Key point: hooks let you initialize/clean up after wiring, before teardown

4. **@Component vs @Bean: Choosing**
   - No new visual (decision guidance in body + short comparison)
   - Key point: `@Component` for classes you own; `@Bean` for third-party or per-construction logic

## Coming From Java Angle

Pure Java: hand-roll singletons (static fields / enum), static factory methods, and manage
init/teardown yourself (constructors + try/finally to close resources). No standard lifecycle.

## Code Examples

- `@Configuration` + `@Bean` factory methods (~14 lines)
- singleton vs `@Scope("prototype")` (~12 lines)
- `@PostConstruct` / `@PreDestroy` cache (~14 lines)

## SVG Diagrams

- config-bean: 640×300, two-route-to-container layout
- scopes: 640×280, singleton vs prototype side-by-side
- lifecycle: 700×180, horizontal stage timeline with the two hooks highlighted
