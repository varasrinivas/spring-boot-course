# M18 Lab — Understand It Path

> **Module:** M18 · JWT Authentication
> **Track:** Spring Security
> **Time:** ~30 minutes

---

## Goal

Understand stateless token auth end to end: issuing, structure, and validation for the Prior
Authorization API.

---

## Part 1: Read the Code (10 min)

```java
String token = Jwts.builder()
    .subject(user.getUsername())
    .claim("roles", user.getAuthorities())
    .expiration(Date.from(now.plus(Duration.ofHours(1))))
    .signWith(key).compact();

// filter:
Jws<Claims> jws = Jwts.parser().verifyWith(key).build().parseSignedClaims(token);
SecurityContextHolder.getContext().setAuthentication(toAuthentication(jws.getPayload()));
```

**Questions:**

1. The token has three dot-separated parts. What's in each, and which one is *not* encrypted?
2. An attacker edits the `roles` claim to add `ADMIN`. Why does validation fail?
3. Why does the server need *no* session or database lookup to authenticate a request?
4. What happens when a token's `exp` has passed and the filter parses it?

---

## Part 2: Stateless vs Session (10 min)

| Aspect | Session | JWT |
|--------|---------|-----|
| Where user state lives | | |
| Scaling across instances | | |
| What the server stores | | |
| Cross-service auth | | |

---

## Part 3: Predict (10 min)

| Question | Your Answer |
|----------|-------------|
| Why keep access tokens short-lived? | |
| HMAC vs RSA signing — when would you choose asymmetric? | |
| Where must the signing key live, and never live? | |
| After the filter sets the SecurityContext, which earlier module's rules take over? | |

---

## You'll know it worked when:

- [ ] You can decode a JWT's three parts and explain each
- [ ] You can explain why the signature prevents tampering
- [ ] You can contrast stateless JWT with server sessions
- [ ] You can trace token → filter → SecurityContext → authorization
