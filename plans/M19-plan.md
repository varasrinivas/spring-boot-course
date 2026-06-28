# M19 Plan — OAuth2 Resource Server

**Track:** Spring Security (key: security, color: #f87171)
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Resource Server vs Custom JWT — visual `m19-resource-server` (IdP issues, your API validates)
2. Configuring the Resource Server — visual `m19-jwt-validation` (JwtDecoder + JWKS + checks); code config + yaml
3. Scopes & Authorities Mapping — visual `m19-scopes` (claims → authorities → rules); code converter
4. OAuth2 Roles & Why an IdP — visual `m19-oauth-roles` (4 actors)

## Coming From Java
M18 DIY token mint + filter + key mgmt; or manual JWKS/verify/parse. Resource server:
declarative oauth2ResourceServer().jwt(), automatic JWKS + validation + authority mapping.

## Code
- SecurityFilterChain .oauth2ResourceServer(jwt) + hasAuthority(SCOPE_)
- issuer-uri yaml
- JwtAuthenticationConverter for role mapping

## SVG
- resource-server 640×270, jwt-validation 640×260, scopes 640×260, oauth-roles 640×260
