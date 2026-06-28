# M01 Lab — Build It with AI Path

> **Module:** M01 · IoC & Dependency Injection
> **Track:** Spring Core Fundamentals
> **Time:** ~45 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Build the first wired slice of the Prior Authorization Service — a `PriorAuthService` backed
by a `PriorAuthRepository` — using Claude Code as your pair programmer. You drive the design
decisions (injection style, interface boundaries); Claude Code handles the boilerplate.

---

## Setup

```powershell
# Navigate to your project
cd C:\Projects\prior-auth-service

# Start Claude Code
claude
```

> No project yet? Ask Claude Code: *"Scaffold a minimal Spring (Core, not Boot) project with
> an AnnotationConfigApplicationContext entry point so I can practice dependency injection."*

---

## Step 1: Scaffold the Beans (10 min)

Ask Claude Code:

> "Create three classes for the Prior Authorization Service using **constructor injection**:
> a `PriorAuthRepository` interface with `PriorAuthRequest save(PriorAuthRequest r)`; an
> `@Repository` implementation `InMemoryPriorAuthRepository` backed by a `Map`; and an
> `@Service` `PriorAuthService` that depends on the `PriorAuthRepository` interface and
> exposes `PriorAuthRequest submit(PriorAuthRequest r)`. The `PriorAuthRequest` record has
> authNumber (String) and cptCode (String)."

**Review what Claude generates.** Before accepting:
- Is `PriorAuthService` depending on the **interface**, not the concrete class?
- Is the repository field `final` and injected via the constructor (no `@Autowired` needed)?
- Could you explain every annotation to a teammate?

---

## Step 2: Make the Container Do the Wiring (15 min)

Now prove the container — not your `main` — wires the graph:

> "Add an `@Configuration` class with `@ComponentScan(\"com.payer.priorauth\")` and a `main`
> method that boots an `AnnotationConfigApplicationContext`, pulls the `PriorAuthService`
> bean out with `context.getBean(PriorAuthService.class)`, and submits one sample request.
> Print the bean's identity hash to show it's a singleton."

**Your judgment call:** Run it twice asking for the bean. Confirm you get the **same**
instance (singleton scope). Then ask Claude to explain *why* you never wrote `new
PriorAuthService(...)` yourself.

---

## Step 3: Prove Testability (10 min)

This is the whole point of DI. Ask Claude Code:

> "Write a JUnit 5 unit test for `PriorAuthService` that uses Mockito to mock
> `PriorAuthRepository`, constructs the service with plain `new` (no Spring container),
> submits a request, and verifies `save` was called. Include one assertion on the
> returned request."

Run the tests:

```powershell
.\mvnw test -Dtest="PriorAuthServiceTest"
```

The test must **not** start a Spring context — that's the proof constructor injection
gives you: testing in milliseconds without the container.

---

## Step 4: Reflect (10 min)

Answer honestly:
- [ ] Could you build this without Claude Code? Which parts did you genuinely understand?
- [ ] What did Claude Code get wrong or over-engineer that you had to correct?
- [ ] You unit-tested `PriorAuthService` with no Spring context at all. Which injection style
      made that possible, and why would field injection have made it harder?

---

## You'll know it worked when:

- [ ] The app boots an `ApplicationContext` and wires the graph with no manual `new`
- [ ] Requesting the bean twice returns the same singleton instance
- [ ] The unit test passes **without** starting Spring
- [ ] You made at least one design decision (injection style or interface boundary) that
      overrode Claude's first suggestion
