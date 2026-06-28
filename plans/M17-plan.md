# M17 Plan — Security Fundamentals

**Track:** Spring Security (key: security, color: #f87171) — START of Track 5
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. The Security Filter Chain — visual `m17-filter-chain` (filters before DispatcherServlet)
2. SecurityFilterChain Bean / lambda DSL — visual `m17-securityconfig` (URL → rule)
3. Authentication: UserDetailsService & PasswordEncoder — visual `m17-authentication`
4. CORS, CSRF & Stateless APIs — visual `m17-cors-csrf`

## Coming From Java
Hand-rolled auth filter + session, scattered role checks, DIY password hashing.
Spring Security: configured filter chain, UserDetails/PasswordEncoder, declarative URL rules.

## Code
- SecurityFilterChain @Bean (authorizeHttpRequests, csrf disable, stateless, httpBasic)
- PasswordEncoder (BCrypt) + UserDetailsService (InMemory)
- CORS source + CSRF note

## SVG
- filter-chain 640×260, securityconfig 640×270, authentication 640×260, cors-csrf 640×250
