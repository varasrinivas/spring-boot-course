# M07 Plan — Configuration & Profiles

**Track:** Spring Boot Essentials (key: boot, color: #5e86c7)
**Level:** Foundational
**Status:** ✅ BUILT

## Concepts

1. **Externalized Configuration & Property-Source Precedence**
   - Visual: `m07-property-sources` — precedence ladder (cmd-line > env vars >
     application-{profile}.yml > application.yml > defaults)
   - Key point: config lives outside code; many sources merged by a defined precedence
     (bridges M06 — properties tune auto-config)

2. **@Value vs @ConfigurationProperties**
   - Visual: `m07-value-vs-props` — a yml group feeding @Value (one key) vs
     @ConfigurationProperties (type-safe group binding)
   - Code: `@Value` field and a `@ConfigurationProperties` record `PayerProperties`
   - Key point: @Value for the odd single value; @ConfigurationProperties for grouped, typed config

3. **Profiles: Environment-Specific Config**
   - Visual: `m07-profiles` — spring.profiles.active selects dev/test/prod; profile yml +
     @Profile beans merge over base
   - Code: `application.yml` + `application-prod.yml` + a `@Profile("dev")` bean
   - Key point: activate with spring.profiles.active; profile config overrides base

4. **Type-Safe, Validated & Secure Config**
   - Visual: `m07-config-safety` — @Validated properties fail fast; secrets via ${ENV}, not committed
   - Code: `@Validated @ConfigurationProperties` with @NotBlank/@Min; api-key from ${PAYER_API_KEY}
   - Key point: validate config at startup; keep secrets in env/secret store, never in yml

## Coming From Java Angle

Pre-Boot: load .properties by hand (Properties.load), System.getProperty, per-env config baked
at build time (Maven filtering) or files swapped at deploy. Boot: layered property sources,
profiles, type-safe binding.

## Code Examples

- @Value field + @ConfigurationProperties record (~10 lines)
- application.yml + application-prod.yml + @Profile bean (~14 lines)
- @Validated config + secret from env var (~8 lines)

## SVG Diagrams

- property-sources: 640×300, 5-rung precedence ladder
- value-vs-props: 640×290, yml → @Value vs @ConfigurationProperties
- profiles: 640×280, active-profile selection merging over base
- config-safety: 640×240, validation + secrets-from-env
