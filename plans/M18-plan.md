# M18 Plan — JWT Authentication

**Track:** Spring Security (key: security, color: #f87171)
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Why JWT for Stateless APIs — visual `m18-jwt-flow` (login → token → bearer on each request)
2. Anatomy of a JWT — visual `m18-jwt-anatomy` (header.payload.signature decoded)
3. Issuing Tokens — code: build + sign with claims + expiry (JJWT)
4. Validating Tokens: OncePerRequestFilter — visual `m18-jwt-filter`, code: the filter

## Coming From Java
Server-side sessions (HttpSession, sticky/shared store) or credentials every call.
JWT: self-contained signed token, no server session, validate by signature.

## Code
- issue() builds signed JWT (sub, roles, exp)
- JwtAuthFilter extends OncePerRequestFilter (extract/verify/setContext)

## SVG
- jwt-flow 640×270, jwt-anatomy 640×270, jwt-filter 640×260
- (concept 3 uses jwt-anatomy context; 3 visuals + 1 code-only concept)
