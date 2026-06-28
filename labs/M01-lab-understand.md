# M01 Lab — Understand It Path

> **Module:** M01 · IoC & Dependency Injection
> **Track:** Spring Core Fundamentals
> **Time:** ~30 minutes

---

## Goal

Walk through Inversion of Control and dependency injection hands-on. By the end, you'll be
able to explain to a teammate *why* a `PriorAuthService` should never call `new` on its own
repository — and where the container fits in the Prior Authorization Service.

---

## Part 1: Read the Code (10 min)

Read this slice of the Prior Authorization Service line by line.

```java
public interface PriorAuthRepository {
    PriorAuthRequest save(PriorAuthRequest request);
}

@Repository
public class JpaPriorAuthRepository implements PriorAuthRepository {
    public PriorAuthRequest save(PriorAuthRequest request) { /* persist via JPA */ return request; }
}

@Service
public class PriorAuthService {

    private final PriorAuthRepository repository;   // depends on the INTERFACE

    public PriorAuthService(PriorAuthRepository repository) {
        this.repository = repository;               // injected by the container
    }

    public PriorAuthRequest submit(PriorAuthRequest request) {
        return repository.save(request);
    }
}
```

**Questions to answer:**

1. Which annotation tells Spring to register `PriorAuthService` as a bean, and which
   `@Component` specialization is it?
2. There is no `@Autowired` anywhere — so how does the container know to inject a
   `PriorAuthRepository` into `PriorAuthService`?
3. `PriorAuthService` depends on the `PriorAuthRepository` *interface*, not
   `JpaPriorAuthRepository`. Why does that matter? What would break if the field type were
   the concrete class?
4. What would happen at startup if **no** bean implemented `PriorAuthRepository`? When would
   you find out — compile time, startup, or first request?

---

## Part 2: Trace the Wiring (10 min)

The application starts. Describe, in order, what the `ApplicationContext` does:

> A client sends `POST /api/prior-auths` to submit a new authorization request for patient
> "Jane Doe" (member M1002934), CPT 70553 (MRI brain).

Trace through:

1. At **startup**, how does the container discover `JpaPriorAuthRepository`,
   `PriorAuthService`, and `PriorAuthController`? (Hint: component scanning.)
2. In what **order** must these three beans be constructed, and why can't `PriorAuthService`
   be built first?
3. At **request** time, which already-wired bean receives the call, and which collaborator
   does it delegate to?

Sketch the bean graph as three boxes with arrows showing "is injected into".

---

## Part 3: Predict & Verify (10 min)

For each change, predict the result, then verify by reasoning about (or running) the code:

| Scenario | Your Prediction | Actual Result |
|----------|----------------|---------------|
| Add a **second** class `InMemoryPriorAuthRepository` also annotated `@Repository` | | |
| Remove `@Service` from `PriorAuthService` | | |
| Switch to field injection (`@Autowired` on the field, no constructor) — can you still `new` it in a unit test? | | |

---

## You'll know it worked when:

- [ ] You can explain Inversion of Control without looking at notes
- [ ] You can explain why constructor injection beats field injection
- [ ] You can predict what a duplicate-bean situation does at startup (and the fix:
      `@Primary` or `@Qualifier`)
- [ ] You understand the "Coming From Java" difference: who calls `new`
