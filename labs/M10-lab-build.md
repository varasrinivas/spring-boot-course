# M10 Lab — Build It with AI Path

> **Module:** M10 · Request Validation & Error Handling
> **Track:** Building REST APIs
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Make the Prior Authorization API reject bad input and report every error as RFC 7807
`ProblemDetail` — validation, not-found, and conflict — with Claude Code. Then prove each path
returns the right status and a consistent body.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

> Ensure `spring-boot-starter-validation` is on the classpath.

---

## Step 1: Constrain the Request DTO (10 min)

Ask Claude Code:

> "Add Bean Validation constraints to `SubmitPriorAuthRequest`: `@NotBlank patientMemberId`,
> `@Pattern(\"\\d{10}\") providerNpi`, `@Pattern(\"\\d{5}\") cptCode`, `@Min(1) units`. Add
> `@Valid` to the `@RequestBody` parameter in the controller."

Test it:

```powershell
curl -X POST http://localhost:8080/api/prior-auths -H "Content-Type: application/json" `
  -d '{"patientMemberId":"","providerNpi":"12","cptCode":"70553","units":0}' -i
```

**Review:** You should get `400`. Note how the *default* body looks before Step 3 improves it.

---

## Step 2: Domain Exceptions (10 min)

> "Create `PriorAuthNotFoundException` and `DuplicateAuthException`. Throw `NotFound` from the
> service when an `authNumber` lookup misses, and `Duplicate` when submitting a second active
> request for the same patient + CPT. Keep controllers free of try/catch."

---

## Step 3: Central Advice + ProblemDetail (20 min)

> "Create a `@RestControllerAdvice ApiExceptionHandler` returning `ProblemDetail`:
> `PriorAuthNotFoundException` → 404, `DuplicateAuthException` → 409, and
> `MethodArgumentNotValidException` → 400 with a custom `errors` property mapping each invalid
> field to its message. Set a meaningful `title` and `type` on each."

Verify all three produce `application/problem+json`:

```powershell
# 400 with field errors
curl -X POST http://localhost:8080/api/prior-auths -H "Content-Type: application/json" `
  -d '{"patientMemberId":"","providerNpi":"12","cptCode":"7","units":0}' -i
# 404
curl http://localhost:8080/api/prior-auths/PA-2026-999999 -i
# 409 (submit the same valid request twice)
```

**Your judgment call:** Are the error bodies identical in shape across all three? That
consistency is the whole point.

---

## Step 4: Reflect (10 min)

- [ ] How many `try/catch` blocks are in your controllers? (Aim: zero.)
- [ ] Which fields in your error body are RFC 7807 standard vs custom?
- [ ] If you added a new `PaymentRequiredException`, how many places change?

---

## You'll know it worked when:

- [ ] Invalid input returns `400` with a per-field `errors` map
- [ ] Missing/duplicate return `404`/`409`
- [ ] Every error is `application/problem+json` with the same structure
- [ ] Controllers and services contain no error-formatting code
