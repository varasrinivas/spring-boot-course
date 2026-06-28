# M01 Plan — IoC & Dependency Injection

**Track:** Spring Core Fundamentals (color: #1e3a5f)
**Level:** Foundational
**Status:** ✅ BUILT

## Concepts

1. **Inversion of Control: The Container Owns Object Creation**
   - Visual: `m01-ioc-container` — left/right comparison: "You `new` everything" vs
     "The ApplicationContext creates and injects beans"
   - Key point: control of object construction is *inverted* from your code to the container

2. **The Three Injection Styles**
   - Visual: `m01-di-styles` — three cards: Constructor (recommended), Setter, Field
   - Code: `PriorAuthService` with constructor injection of `PriorAuthRepository`
   - Key point: prefer constructor injection — immutable, testable, fails fast

3. **Component Scanning & @Autowired**
   - Visual: `m01-component-scan` — `@ComponentScan` discovering `@Service`/`@Repository`
     stereotypes and registering them as beans
   - Code: `@Repository`, `@Service`, `@RestController` stereotype stack
   - Key point: stereotypes are `@Component` specializations the scanner auto-registers

4. **Why DI Matters: Testability & Loose Coupling**
   - Visual: (reuses concept 2 card layout — no new SVG)
   - Code: unit test swapping a mock `PriorAuthRepository` into `PriorAuthService`
   - Key point: depending on interfaces + injected collaborators = trivial mocking

## Coming From Java Angle

Pure Java: `new PriorAuthService(new JpaPriorAuthRepository(new DataSource(...)))` — every
caller hand-wires the full dependency graph; swapping an implementation means editing
every construction site. Spring: declare the dependency, the container resolves the graph.

## Code Examples

- Constructor-injected `PriorAuthService` (~12 lines)
- Stereotype stack: `@Repository` / `@Service` / `@RestController` (~15 lines)
- Unit test injecting a mock repository (~14 lines)

## SVG Diagrams

- IoC container: 660×300, two-panel before/after with central ApplicationContext box
- DI styles: 640×240, three comparison cards
- Component scan: 640×280, package → scanner → bean registry flow
