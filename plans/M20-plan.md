# M20 Plan — Method-Level Security

**Track:** Spring Security (key: security, color: #f87171) — LAST of Track 5
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Method vs URL Security — visual `m20-method-vs-url` (defense in depth)
2. @PreAuthorize & SpEL — visual `m20-preauthorize` (SpEL → allow/deny 403)
3. Expression-Based & Object-Level Rules — visual `m20-spel` (args/principal/bean/returnObject)
4. Testing Secured Endpoints — visual `m20-security-test` (@WithMockUser matrix)

## Coming From Java
Scattered manual if-checks at method tops, duplicated, forgettable, untested.
Spring: declarative @PreAuthorize, SpEL, @WithMockUser tests.

## Code
- @EnableMethodSecurity
- @PreAuthorize hasRole/hasAuthority
- object-level SpEL with #args + @bean + @PostAuthorize
- @WithMockUser MockMvc tests (200/403)

## SVG
- method-vs-url 640×260, preauthorize 640×250, spel 640×270, security-test 640×250
