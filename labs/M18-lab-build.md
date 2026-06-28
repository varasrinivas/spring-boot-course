# M18 Lab — Build It with AI Path

> **Module:** M18 · JWT Authentication
> **Track:** Spring Security
> **Time:** ~55 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Replace HTTP Basic with JWT: a login endpoint that issues a signed token, and a filter that
validates it — so the Prior Authorization API is fully stateless.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

> Add the `jjwt` dependencies (api, impl, jackson).

---

## Step 1: Issue Tokens (15 min)

Ask Claude Code:

> "Add a `JwtService` that issues an HS256 token with `subject`, a `roles` claim, and a 1-hour
> expiry, signing with a key loaded from `priorauth.jwt.secret` (config, not code). Add a
> `POST /auth/login` endpoint that authenticates via the `AuthenticationManager` and returns the
> token."

```powershell
$token = (curl -s -X POST http://localhost:8080/auth/login -H "Content-Type: application/json" `
  -d '{"username":"reviewer","password":"secret"}' | ConvertFrom-Json).token
$token
```

Paste the token into jwt.io (or decode it) and confirm the claims.

---

## Step 2: Validate with a Filter (20 min)

> "Add a `JwtAuthFilter extends OncePerRequestFilter` that reads the `Bearer` token, verifies it,
> builds an `Authentication` with the roles, and sets the `SecurityContext`. Register it before
> `UsernamePasswordAuthenticationFilter`. Switch the chain from `httpBasic` to stateless +
> this filter."

Test:

```powershell
# no token → 401
curl -i http://localhost:8080/api/prior-auths
# with token → authorized per role
curl -i http://localhost:8080/api/prior-auths -H "Authorization: Bearer $token"
```

**Your judgment call:** Tamper with one character of the token and confirm it's rejected.

---

## Step 3: Expiry & Errors (15 min)

> "Make expiry configurable and add clean handling: expired/invalid tokens result in `401` with
> a `ProblemDetail` body (reuse the M10 advice). Add a test that an expired token is rejected."

---

## Step 4: Reflect (5 min)

- [ ] What server-side state does authentication now require? (Aim: none.)
- [ ] Why does this design set you up well for microservices (Track 6)?
- [ ] What's the risk if the signing secret leaks, and how do you mitigate it?

---

## You'll know it worked when:

- [ ] `POST /auth/login` returns a valid, decodable JWT
- [ ] Requests with a valid `Bearer` token are authorized by role
- [ ] Tampered or expired tokens return `401`
- [ ] No `HttpSession` is created for API calls
