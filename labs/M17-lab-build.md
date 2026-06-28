# M17 Lab — Build It with AI Path

> **Module:** M17 · Security Fundamentals
> **Track:** Spring Security
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Lock down the Prior Authorization API: a SecurityFilterChain with real rules, BCrypt-hashed
in-memory users, and correct CSRF/CORS for a stateless API — verified with authenticated and
unauthenticated calls.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

> Add `spring-boot-starter-security`.

---

## Step 1: Filter Chain & Rules (15 min)

Ask Claude Code:

> "Add a `SecurityFilterChain` bean: permit `/actuator/health` and `/swagger-ui/**`; require role
> `SUBMITTER` for `POST /api/prior-auths`; require `REVIEWER` for
> `PATCH /api/prior-auths/*/decision`; authenticate all other `/api/prior-auths/**`; deny the
> rest. Disable CSRF, set stateless sessions, enable HTTP Basic."

**Review:** Is `anyRequest().denyAll()` last? Are the method-specific rules before the general one?

---

## Step 2: Users & Password Hashing (15 min)

> "Add a `BCryptPasswordEncoder` bean and an in-memory `UserDetailsService` with a `submitter`
> (role SUBMITTER) and a `reviewer` (role REVIEWER), passwords hashed via the encoder."

Test allow/deny:

```powershell
# anonymous — should be 401
curl -i http://localhost:8080/api/prior-auths
# reviewer trying to submit — should be 403
curl -i -u reviewer:secret -X POST http://localhost:8080/api/prior-auths -H "Content-Type: application/json" -d '{}'
# submitter submitting — should pass authz (then hit validation)
curl -i -u submitter:secret -X POST http://localhost:8080/api/prior-auths -H "Content-Type: application/json" -d '{}'
```

**Your judgment call:** Confirm the 401 vs 403 distinction matches your expectation.

---

## Step 3: CORS (10 min)

> "Add a CORS configuration allowing origin `http://localhost:5173` for `GET/POST/PATCH/DELETE`
> and enable it on the chain. Show me a preflight `OPTIONS` succeeding."

```powershell
curl -i -X OPTIONS http://localhost:8080/api/prior-auths `
  -H "Origin: http://localhost:5173" -H "Access-Control-Request-Method: POST"
```

---

## Step 4: Reflect (10 min)

- [ ] Which endpoints are public, and is that the minimum necessary?
- [ ] Why does `submitter` get 403 (not 401) on a reviewer-only action?
- [ ] What will replace HTTP Basic + in-memory users in M18/M19?

---

## You'll know it worked when:

- [ ] Anonymous calls to protected endpoints return `401`
- [ ] Authenticated-but-wrong-role calls return `403`
- [ ] Passwords are BCrypt-hashed, never plaintext
- [ ] A CORS preflight from the allowed origin succeeds
