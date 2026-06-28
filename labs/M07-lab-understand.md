# M07 Lab — Understand It Path

> **Module:** M07 · Configuration & Profiles
> **Track:** Spring Boot Essentials
> **Time:** ~30 minutes

---

## Goal

Get fluent with where configuration comes from, how it binds, and how it changes per
environment — using the Prior Authorization Service's payer settings.

---

## Part 1: Read the Code (10 min)

```java
@Validated
@ConfigurationProperties(prefix = "priorauth.payer")
public record PayerProperties(
        @NotBlank String baseUrl,
        @NotNull Duration timeout,
        @Min(1) int maxRetries) {
}
```

```yaml
# application.yml (base)
priorauth:
  payer:
    base-url: https://sandbox.payer.test
    timeout: 5s
    max-retries: 3
---
# application-prod.yml
priorauth:
  payer:
    base-url: https://api.payer.com
    max-retries: 5
```

**Questions to answer:**

1. With `prod` active, what are the effective values of `baseUrl`, `timeout`, and
   `maxRetries`? Which come from the base file and which from the profile file?
2. How does the string `5s` become a `Duration`? What does the same binding do for
   `max-retries` → `maxRetries` (note the name shape)?
3. A deploy sets `priorauth.payer.base-url` to an empty string. What happens at startup, and
   which annotation is responsible?
4. Would you bind these three settings with `@Value` instead? Why or why not?

---

## Part 2: Resolve the Precedence (10 min)

The same key `priorauth.payer.max-retries` is set in several places. Circle the winner:

| Source | Value |
|--------|-------|
| `application.yml` | 3 |
| `application-prod.yml` (prod active) | 5 |
| Environment variable `PRIORAUTH_PAYER_MAX_RETRIES=8` | 8 |
| Command line `--priorauth.payer.max-retries=10` | 10 |

**Winner: ____.** Now list the four sources from highest to lowest precedence.

---

## Part 3: Predict & Verify (10 min)

| Scenario | Your Prediction |
|----------|-----------------|
| No `spring.profiles.active` set — which yml files load? | |
| `@Bean @Profile("dev") PolicyLoader` with `prod` active — does the bean exist? | |
| `api-key: ${PAYER_API_KEY}` but the env var is unset — what happens? | |
| You commit a real API key into `application.yml` — what's the risk? | |

---

## You'll know it worked when:

- [ ] You can order the property-source precedence from memory
- [ ] You can compute effective values when base + profile both set a key
- [ ] You can explain when to use `@ConfigurationProperties` over `@Value`
- [ ] You can explain how secrets stay out of source control
