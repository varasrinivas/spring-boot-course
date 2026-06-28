# M19 Lab — Build It with AI Path

> **Module:** M19 · OAuth2 Resource Server
> **Track:** Spring Security
> **Time:** ~55 minutes
> **Requires:** Claude Code, JDK 21, IDE, Docker (for Keycloak)

---

## Goal

Turn the Prior Authorization API into an OAuth2 resource server validating tokens from a real
IdP (Keycloak in Docker), and authorize on scopes and roles.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: Run an IdP & Point at It (15 min)

Ask Claude Code:

> "Add a `docker-compose.yml` running Keycloak with a `priorauth` realm, a `reviewer` user, and
> a client. Add `spring-boot-starter-oauth2-resource-server` and set
> `spring.security.oauth2.resourceserver.jwt.issuer-uri` to the realm. Replace the M18 custom
> filter/login with `oauth2ResourceServer().jwt()`."

Get a token from Keycloak and call the API:

```powershell
# fetch a token from Keycloak's token endpoint (Claude can give the exact curl)
curl -i http://localhost:8080/api/prior-auths -H "Authorization: Bearer $token"
```

**Review:** Did you delete the hand-written JWT code from M18? Good — that's the point.

---

## Step 2: Authorize on Scopes (15 min)

> "Gate `POST /api/prior-auths` on `SCOPE_prior-auth:write` and a read endpoint on
> `SCOPE_prior-auth:read`. Configure those scopes on the Keycloak client."

Test that a read-only token is rejected (`403`) on the write endpoint.

---

## Step 3: Map Realm Roles (15 min)

> "Add a `JwtAuthenticationConverter` that maps Keycloak `realm_access.roles` to `ROLE_`
> authorities, and gate `PATCH /api/prior-auths/*/decision` on `hasRole('REVIEWER')`."

Confirm a token with the `REVIEWER` realm role can decide, and one without cannot.

---

## Step 4: Reflect (10 min)

- [ ] How much security-critical code did you delete vs M18?
- [ ] Why is the resource server unaffected when Keycloak rotates keys?
- [ ] How does this model extend to many services behind one gateway (Track 6)?

---

## You'll know it worked when:

- [ ] The API validates real Keycloak-issued tokens with no custom filter
- [ ] Scope-gated endpoints reject tokens lacking the scope
- [ ] Role-gated endpoints honor mapped realm roles
- [ ] Your service holds no signing secret and no passwords
