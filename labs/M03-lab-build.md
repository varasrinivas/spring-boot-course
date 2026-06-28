# M03 Lab — Build It with AI Path

> **Module:** M03 · Aspect-Oriented Programming
> **Track:** Spring Core Fundamentals
> **Time:** ~45 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Extract audit logging and call timing out of the Prior Authorization Service's business
methods and into reusable aspects — then watch them fire (and catch the self-invocation
gotcha) using Claude Code.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: Write an Audit Aspect (15 min)

Ask Claude Code:

> "Create an `@Aspect @Component AuditAspect` in `com.payer.priorauth.audit`. Add a `@Before`
> advice with pointcut `execution(* com.payer.priorauth.service.*.*(..))` that logs the method
> name and arguments. Make sure spring-boot-starter-aop is on the classpath."

**Review before accepting:**
- Is the aspect a Spring bean (`@Component`)?
- Does the pointcut target the service package only — not controllers or repositories?
- Could you read the pointcut expression aloud and explain each segment?

---

## Step 2: Add an @Around Timing Aspect (10 min)

> "Add a `TimingAspect` with `@Around` advice over `PayerClient` method executions that logs how
> many milliseconds each call took. Use `ProceedingJoinPoint` and a try/finally so timing is
> recorded even when the call throws."

**Your judgment call:** Confirm Claude calls `proceed()` exactly once and returns its result.
Ask: *what would break if proceed() were called twice?*

---

## Step 3: Reproduce & Fix Self-Invocation (15 min)

> "Create a custom `@Audited` annotation and an `@Around(\"@annotation(Audited)\")` aspect that
> logs 'AUDIT: <method>'. Annotate both `submit()` and `approve()` in `PriorAuthService`, where
> `submit()` internally calls `this.approve()`. Add a runner that calls `submit()` once."

Run it. You should see `AUDIT: submit` but **not** `AUDIT: approve`.

Now ask Claude Code:

> "Why didn't approve() get audited, and how do I fix it without merging the methods?"

Apply one fix (self-injection of the bean, or `AopContext.currentProxy()`, or extracting
`approve()` to another bean) and confirm both now log.

---

## Step 4: Reflect (5 min)

- [ ] How many lines of logging/timing did you remove from the service methods?
- [ ] Which advice type did each concern need, and why not a weaker one?
- [ ] In your own words: why does self-invocation bypass the proxy?

---

## You'll know it worked when:

- [ ] Service methods contain only business logic — no inline logging/timing
- [ ] The audit aspect logs every service call; the timing aspect logs PayerClient durations
- [ ] You reproduced the self-invocation miss and then fixed it
- [ ] You can defend each advice-type choice
