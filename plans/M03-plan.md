# M03 Plan — Aspect-Oriented Programming

**Track:** Spring Core Fundamentals (color: #6ea3d8)
**Level:** Foundational
**Status:** ✅ BUILT

## Concepts

1. **Cross-Cutting Concerns: The Problem AOP Solves**
   - Visual: `m03-cross-cutting` — service methods tangled with logging/security/timing
     vs clean business methods with aspects applied across them
   - Code: a `submit()` method polluted with logging + security + timing lines
   - Key point: concerns that cut across many methods get scattered and duplicated

2. **Aspects, Pointcuts & Advice: The Vocabulary**
   - Visual: `m03-aop-vocab` — anatomy: an @Aspect = a pointcut (where) + advice (what),
     applied at join points (method executions)
   - Code: `@Aspect AuditAspect` with a `@Before` pointcut on the service package
   - Key point: pointcut selects join points; advice is the code that runs there

3. **Advice Types: @Before, @AfterReturning, @AfterThrowing, @Around**
   - Visual: `m03-advice-types` — timeline around a method call showing where each fires
   - Code: `@Around TimingAspect` wrapping PayerClient calls with `proceed()`
   - Key point: @Around is the most powerful — it controls whether/when the target runs

4. **How Spring AOP Works: Proxies**
   - Visual: `m03-proxy` — caller → proxy → advice → target bean; self-calls bypass the proxy
   - Code: `@Around("@annotation(Audited)")` custom-annotation pointcut
   - Key point: Spring wraps beans in proxies; in-class self-invocation skips advice

## Coming From Java Angle

Pure Java: hand-rolled decorators/wrappers per interface, or copy-pasted logging/security/
timing into every method; servlet filters cover only the web edge, not service internals.

## Code Examples

- tangled `submit()` showing scattered concerns (~9 lines)
- `@Aspect` + `@Before` audit aspect (~10 lines)
- `@Around` timing aspect with `proceed()` (~12 lines)
- custom `@annotation` pointcut (~3 lines)

## SVG Diagrams

- cross-cutting: 640×300, tangled-vs-clean two-panel
- aop-vocab: 640×260, aspect anatomy → join points
- advice-types: 660×250, advice firing timeline around a method
- proxy: 640×230, proxy wrapping the target bean
