# M06 Lab — Build It with AI Path

> **Module:** M06 · Auto-Configuration & Starters
> **Track:** Spring Boot Essentials
> **Time:** ~45 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Make auto-configuration visible and bend it to your will: read the condition report, override an
auto-configured bean, and tune another with a property — all on the Prior Authorization Service.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: See What Boot Auto-Configured (10 min)

Run with the condition evaluation report on:

```powershell
.\mvnw spring-boot:run --% -Dspring-boot.run.arguments=--debug
```

Ask Claude Code:

> "From this condition evaluation report, list five auto-configurations under Positive matches
> and explain what each contributed. Then show two Negative matches and why they didn't apply."

**Review:** Can you find `DataSourceAutoConfiguration`? Is it positive or negative, and why?

---

## Step 2: Override an Auto-Configured Bean (15 min)

> "Add an explicit `@Bean ObjectMapper` that registers the JavaTimeModule and disables
> `WRITE_DATES_AS_TIMESTAMPS`, so prior-auth `requestDate` values serialize as ISO strings.
> Confirm via the condition report that Boot's auto-configured ObjectMapper backed off."

**Your judgment call:** Hit a JSON endpoint before and after. Confirm the date format changed,
and find the Negative match line proving your bean won. Which annotation in Boot's
auto-config made the back-off automatic?

---

## Step 3: Tune a Default with a Property (10 min)

> "Without writing any Java, set the embedded server port to 9090 and the Hikari pool max size
> to 15 using application.properties. Then show me where in the actuator `configprops`
> endpoint these values appear."

```powershell
# verify
curl http://localhost:9090/actuator/health
```

Confirm the app now serves on 9090 — proving a property reconfigured an auto-configured bean
with zero code.

---

## Step 4: Reflect (10 min)

- [ ] Name one bean you *overrode* (your @Bean) and one you *tuned* (a property). Why each
      approach?
- [ ] How would you explain "auto-configuration" to a teammate in two sentences?
- [ ] What's the fastest way to answer "why does this bean exist?" in a Boot app?

---

## You'll know it worked when:

- [ ] You read the condition evaluation report and located real positive/negative matches
- [ ] Your custom `ObjectMapper` overrode Boot's, confirmed by a Negative match
- [ ] A property change moved the port and resized the pool with no Java
- [ ] You can articulate the override precedence from memory
