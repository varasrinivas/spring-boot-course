# M19 Lab — Understand It Path

> **Module:** M19 · OAuth2 Resource Server
> **Track:** Spring Security
> **Time:** ~30 minutes

---

## Goal

Understand how delegating authentication to an IdP turns your service into a token-validating
resource server.

---

## Part 1: Read the Code (10 min)

```java
http
  .authorizeHttpRequests(auth -> auth
      .requestMatchers(HttpMethod.POST, "/api/prior-auths").hasAuthority("SCOPE_prior-auth:write")
      .requestMatchers("/api/prior-auths/**").authenticated()
      .anyRequest().denyAll())
  .oauth2ResourceServer(oauth -> oauth.jwt(Customizer.withDefaults()));
// spring.security.oauth2.resourceserver.jwt.issuer-uri: https://idp.payer.com/realms/priorauth
```

**Questions:**

1. Where does the `issuer-uri` lead Spring, and what does it fetch from there?
2. The M18 token filter is gone. What replaced its signature/expiry checks?
3. `hasAuthority("SCOPE_prior-auth:write")` — where did that authority come from in the token?
4. Your service holds no signing secret. How can it still verify tokens?

---

## Part 2: Roles & Responsibilities (10 min)

| OAuth2 role | Who/what | Responsibility |
|-------------|----------|----------------|
| Resource owner | | |
| Client | | |
| Authorization server | | |
| Resource server | | |

---

## Part 3: Scope vs Role (10 min)

| Question | Your Answer |
|----------|-------------|
| What's the difference between a scope and a role claim? | |
| Which would you use to gate a write endpoint, and why? | |
| How do custom realm roles become `ROLE_` authorities? | |
| What happens automatically when the IdP rotates its signing keys? | |

---

## You'll know it worked when:

- [ ] You can explain resource server vs authorization server
- [ ] You can name what `issuer-uri` enables
- [ ] You can map token claims to Spring authorities
- [ ] You can justify delegating auth to an IdP
