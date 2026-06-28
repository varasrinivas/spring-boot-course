# M02 Lab — Build It with AI Path

> **Module:** M02 · Beans, Scopes & Lifecycle
> **Track:** Spring Core Fundamentals
> **Time:** ~45 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Wire up the Prior Authorization Service's configuration and a lifecycle-aware policy cache
using Claude Code. You'll define beans explicitly, choose scopes deliberately, and prove the
lifecycle hooks fire in the right order.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: Define Beans with @Configuration (10 min)

Ask Claude Code:

> "Create a `@Configuration` class `PriorAuthConfig` in `com.payer.priorauth.config` with two
> `@Bean` methods: a `Clock` returning `Clock.systemUTC()`, and a `PayerClient` built from a
> `payer.base-url` property with a 5-second timeout. Add the property to
> `application.properties`."

**Review before accepting:**
- Is `PayerClient` a `@Bean` (not `@Component`) — and can you explain *why*?
- Does the `payerClient` method receive the URL via `@Value` or a bound config object?

---

## Step 2: Add a Scoped Bean (10 min)

> "Create a singleton `@Service AuthRulesEngine` with a stateless
> `evaluate(PriorAuthRequest)` method, and a `@Scope(\"prototype\")` component
> `MedicalNecessityCheck` that accumulates a `List<String>` of findings."

**Your judgment call:** Ask Claude to write a tiny runner (or test) that requests
`MedicalNecessityCheck` from the context **twice** and prints `System.identityHashCode(...)`.
Confirm the two hashes **differ** (prototype) — then change it to singleton and confirm they
**match**. Explain the difference to yourself.

---

## Step 3: Prove the Lifecycle (15 min)

> "Create a `@Component AuthPolicyCache` that depends on a `PolicyLoader`. Load a map of CPT →
> Policy in a `@PostConstruct warm()` method (log 'cache warmed: N policies') and clear it in a
> `@PreDestroy flush()` method (log 'cache flushed'). Provide a stub `PolicyLoader` returning a
> few sample CPT codes."

Run the app, then stop it (Ctrl+C / context close). In the logs, confirm the order:

```
... cache warmed: N policies      (at startup, after injection)
... cache flushed                 (at shutdown)
```

If `flush()` doesn't log on shutdown, ask Claude why — and whether a prototype bean would
behave differently.

---

## Step 4: Reflect (10 min)

- [ ] Which beans did you register with `@Component` vs `@Bean`, and why?
- [ ] What would break if `MedicalNecessityCheck` were left at the default singleton scope?
- [ ] Where would constructor logic have failed that `@PostConstruct` handled correctly?

---

## You'll know it worked when:

- [ ] `Clock` and `PayerClient` are container-managed `@Bean`s injected elsewhere
- [ ] Prototype vs singleton identity hashes demonstrably differ / match
- [ ] `@PostConstruct` logs at startup and `@PreDestroy` logs at shutdown, in order
- [ ] You made at least one deliberate scope or registration decision and can defend it
