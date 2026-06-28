# M07 Lab — Build It with AI Path

> **Module:** M07 · Configuration & Profiles
> **Track:** Spring Boot Essentials
> **Time:** ~45 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Make the Prior Authorization Service's payer integration fully configurable: type-safe
properties, per-environment profiles, validation that fails fast, and a secret that never
touches source control. Claude Code writes it; you verify each guarantee.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: Bind Type-Safe Properties (10 min)

Ask Claude Code:

> "Create a `@ConfigurationProperties(prefix=\"priorauth.payer\")` record `PayerProperties`
> with `String baseUrl`, `Duration timeout`, and `int maxRetries`. Enable it with
> `@ConfigurationPropertiesScan` on the main class, then inject it into a `PayerClient` and log
> all three values at startup. Put defaults in `application.yml`."

**Review before accepting:**
- Is it a `record` bound by prefix (not three `@Value` fields)?
- Did `timeout: 5s` bind to a `Duration` without manual parsing?

---

## Step 2: Add Profiles (15 min)

> "Add `application-dev.yml` and `application-prod.yml` that override `base-url` and
> `max-retries`. Create a `PolicyLoader` interface with an `@Profile(\"dev\")` in-memory stub
> bean and an `@Profile(\"prod\")` HTTP-backed bean. Show me how to run under each profile."

Run both and confirm the logged values and active bean change:

```powershell
.\mvnw spring-boot:run --% -Dspring-boot.run.profiles=dev
.\mvnw spring-boot:run --% -Dspring-boot.run.profiles=prod
```

**Your judgment call:** Which `PolicyLoader` is active under each profile? Prove it from the logs.

---

## Step 3: Validate & Secure (15 min)

> "Add `@Validated` to `PayerProperties` with `@NotBlank` on baseUrl and `@Min(1)` on
> maxRetries. Then add `api-key: ${PAYER_API_KEY}` under `priorauth.payer` and bind it as a
> field. Show me that a blank base-url or a missing required value stops startup with a clear
> message."

Test both:

```powershell
# Missing secret / bad value should fail fast, not at first request
$env:PAYER_API_KEY=""; .\mvnw spring-boot:run
```

Confirm the app refuses to start and the message names the offending property.

---

## Step 4: Reflect (5 min)

- [ ] Which settings did you group into `PayerProperties`, and why not `@Value`?
- [ ] How does the same JAR run differently in dev vs prod without a rebuild?
- [ ] Where does the API key live now, and why is that safer than `application.yml`?

---

## You'll know it worked when:

- [ ] `PayerProperties` binds a typed group from `priorauth.payer.*`
- [ ] dev and prod profiles select different values and different beans
- [ ] Invalid config fails startup with a property-named message
- [ ] The API key resolves from an env var, with only `${PAYER_API_KEY}` in the yml
