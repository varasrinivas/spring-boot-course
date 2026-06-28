# M02 Lab — Understand It Path

> **Module:** M02 · Beans, Scopes & Lifecycle
> **Track:** Spring Core Fundamentals
> **Time:** ~30 minutes

---

## Goal

Build a clear mental model of *how many* bean instances exist, *how long* they live, and
*when* lifecycle hooks fire — using the Prior Authorization Service's configuration, rules
engine, and policy cache.

---

## Part 1: Read the Code (10 min)

```java
@Configuration
public class PriorAuthConfig {
    @Bean
    public PayerClient payerClient(@Value("${payer.base-url}") String baseUrl) {
        return PayerClient.builder().baseUrl(baseUrl).timeout(Duration.ofSeconds(5)).build();
    }
    @Bean
    public Clock clock() { return Clock.systemUTC(); }
}

@Component
public class AuthPolicyCache {
    private final PolicyLoader loader;
    private Map<String, Policy> byCpt;
    public AuthPolicyCache(PolicyLoader loader) { this.loader = loader; }

    @PostConstruct void warm()  { byCpt = loader.loadAll(); }
    @PreDestroy    void flush() { byCpt.clear(); }
}
```

**Questions to answer:**

1. Why is `PayerClient` registered with a `@Bean` method instead of `@Component`?
2. The `clock()` bean depends on nothing, but `payerClient(...)` takes a `String` parameter —
   where does that value come from, and how would a `@Bean` method depend on *another bean*?
3. In `AuthPolicyCache`, why must `warm()` run in `@PostConstruct` rather than in the
   constructor? (Hint: what is guaranteed to be true after construction vs after injection?)
4. If `AuthPolicyCache` were `@Scope("prototype")`, which of `warm()` / `flush()` would Spring
   still call, and which would it skip?

---

## Part 2: Count the Instances (10 min)

For each bean below, state how many instances exist in a running app and why:

| Bean | Scope | How many instances? | Why |
|------|-------|--------------------|-----|
| `AuthRulesEngine` (`@Service`) | singleton | | |
| `MedicalNecessityCheck` (`@Scope("prototype")`) | prototype | | |
| `PayerClient` (`@Bean`) | singleton | | |

Then answer: **why must a singleton bean be thread-safe**, but a prototype bean need not be?

---

## Part 3: Predict the Lifecycle Order (10 min)

The app starts, serves two authorization requests, then shuts down. Put these events in order
for `AuthPolicyCache` and a prototype `MedicalNecessityCheck`:

- [ ] `AuthPolicyCache` constructor runs
- [ ] `AuthPolicyCache.warm()` (`@PostConstruct`) runs
- [ ] a new `MedicalNecessityCheck` is created for request 1
- [ ] a new `MedicalNecessityCheck` is created for request 2
- [ ] `AuthPolicyCache.flush()` (`@PreDestroy`) runs
- [ ] (does `@PreDestroy` ever run on the prototype checks? why/why not?)

---

## You'll know it worked when:

- [ ] You can explain when to use `@Component` vs a `@Bean` method
- [ ] You can predict instance counts for singleton vs prototype beans
- [ ] You can order the lifecycle and say what `@PostConstruct`/`@PreDestroy` guarantee
- [ ] You understand why prototype beans don't get `@PreDestroy`
