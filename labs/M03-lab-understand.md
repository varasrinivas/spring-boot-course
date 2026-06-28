# M03 Lab — Understand It Path

> **Module:** M03 · Aspect-Oriented Programming
> **Track:** Spring Core Fundamentals
> **Time:** ~30 minutes

---

## Goal

Build intuition for *where* advice fires and *why* a self-call can silently skip it — using an
audit and timing aspect over the Prior Authorization Service.

---

## Part 1: Read the Code (10 min)

```java
@Aspect
@Component
public class AuditAspect {
    @Before("execution(* com.payer.priorauth.service.*.*(..))")
    public void logEntry(JoinPoint jp) {
        log.info("calling {}", jp.getSignature().getName());
    }
}

@Aspect
@Component
public class TimingAspect {
    @Around("execution(* com.payer.priorauth..PayerClient.*(..))")
    public Object time(ProceedingJoinPoint pjp) throws Throwable {
        long start = System.nanoTime();
        try { return pjp.proceed(); }
        finally { log.info("{} took {}ms", pjp.getSignature().getName(), (System.nanoTime()-start)/1_000_000); }
    }
}
```

**Questions to answer:**

1. Decode the pointcut `execution(* com.payer.priorauth.service.*.*(..))` part by part. What do
   the `*`, the package, and the `(..)` each match?
2. `TimingAspect` uses `@Around` and calls `pjp.proceed()`. What happens if you *forget* to
   call `proceed()`? What does the return value of `proceed()` represent?
3. Why must `AuditAspect` be a `@Component` (not just `@Aspect`)?
4. `@Before` returns `void`, but `@Around` returns `Object`. Why the difference?

---

## Part 2: Order the Advice (10 min)

A single `submit()` call is advised by `@Around`, `@Before`, `@AfterReturning`, and `@After`.
Number these in the order they execute for a **normal** return:

- [ ] `@Around` (before `proceed()`)
- [ ] `@Before`
- [ ] the target method body
- [ ] `@Around` (after `proceed()`)
- [ ] `@AfterReturning`
- [ ] `@After`

Now redo the ordering for the case where the target **throws** — which advice runs, and which
is skipped?

---

## Part 3: Spot the Self-Invocation Bug (10 min)

```java
@Service
public class PriorAuthService {
    @Audited
    public Decision submit(PriorAuthRequest r) { return approve(r); }

    @Audited
    public Decision approve(PriorAuthRequest r) { /* ... */ }
}
```

An `@Around("@annotation(Audited)")` aspect logs every `@Audited` call.

1. A controller calls `service.submit(r)`. Which methods get audited — `submit`, `approve`,
   or both? Why?
2. Explain the proxy mechanism that causes this.
3. Give two ways to make `approve()` get audited when reached via `submit()`.

---

## You'll know it worked when:

- [ ] You can read a basic `execution(...)` pointcut out loud
- [ ] You can order all advice types for both normal and exception flows
- [ ] You can explain why `@Around` needs `proceed()` and the others don't
- [ ] You can describe the self-invocation proxy gotcha and at least one fix
