# M17 Lab — Understand It Path

> **Module:** M17 · Security Fundamentals
> **Track:** Spring Security
> **Time:** ~30 minutes

---

## Goal

Understand how the filter chain authenticates and authorizes calls to the Prior Authorization
API before they reach a controller.

---

## Part 1: Read the Code (10 min)

```java
@Bean
SecurityFilterChain api(HttpSecurity http) throws Exception {
    http
      .authorizeHttpRequests(auth -> auth
          .requestMatchers("/actuator/health", "/swagger-ui/**").permitAll()
          .requestMatchers(HttpMethod.POST, "/api/prior-auths").hasRole("SUBMITTER")
          .requestMatchers("/api/prior-auths/**").authenticated()
          .anyRequest().denyAll())
      .csrf(csrf -> csrf.disable())
      .sessionManagement(s -> s.sessionCreationPolicy(STATELESS))
      .httpBasic(withDefaults());
    return http.build();
}
```

**Questions:**

1. An anonymous `GET /actuator/health` — allowed or blocked? What about an anonymous
   `GET /api/prior-auths/PA-1`?
2. A user with role `REVIEWER` (not `SUBMITTER`) sends `POST /api/prior-auths`. What status comes
   back — `401` or `403`? Why?
3. Why does rule order matter, and what does `anyRequest().denyAll()` protect against?
4. Why is CSRF disabled and the session stateless here?

---

## Part 2: 401 vs 403 (10 min)

| Situation | Status |
|-----------|--------|
| No credentials at all | |
| Valid credentials, insufficient role | |
| Valid credentials, allowed | |
| Bad password | |

---

## Part 3: Predict (10 min)

| Question | Your Answer |
|----------|-------------|
| Why must passwords go through `BCryptPasswordEncoder` rather than be stored as-is? | |
| What does `UserDetailsService.loadUserByUsername` return, and where from? | |
| A browser app on `https://portal.example.com` calls the API on another origin — what must the server allow? | |
| Where does security run relative to your controller? | |

---

## You'll know it worked when:

- [ ] You can trace a request through the filter chain to allow/deny
- [ ] You can distinguish 401 from 403
- [ ] You can explain the UserDetailsService + PasswordEncoder pair
- [ ] You can justify the CSRF/stateless choices for a token API
