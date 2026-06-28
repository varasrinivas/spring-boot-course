# M22 Lab — Build It with AI Path

> **Module:** M22 · Centralized Configuration
> **Track:** Microservices Foundations
> **Time:** ~55 minutes
> **Requires:** Claude Code, JDK 21, a Git repo

---

## Goal

Stand up a Config Server backed by Git, point the prior-auth services at it, refresh a flag live,
and encrypt a secret.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: Config Server + Repo (15 min)

Ask Claude Code:

> "Create a `config-server` Spring Boot app with `@EnableConfigServer` pointing at a Git repo
> `prior-auth-config`. In that repo add `application.yml`, `prior-auth-intake.yml`, and
> `prior-auth-intake-prod.yml`. Run it on 8888."

Verify it serves config:

```powershell
curl http://localhost:8888/prior-auth-intake/prod
```

---

## Step 2: Make a Service a Client (15 min)

> "Point `prior-auth-intake` at the config server via `spring.config.import`. Move its payer URL
> and a `priorauth.features.auto-approve` flag into the config repo. Add the actuator so
> `/actuator/refresh` is available."

Confirm the service boots with values that came from the server (log them at startup).

---

## Step 3: Live Refresh (15 min)

> "Annotate a `FeatureFlags` bean with `@RefreshScope` and bind `auto-approve`. Then: change it
> to `true` in the config repo, commit, and `POST /actuator/refresh`. Show the value changing
> without a restart."

```powershell
# change + commit in the config repo, then:
curl -X POST http://localhost:8081/actuator/refresh
curl http://localhost:8081/api/.../flags   # shows auto-approve = true
```

**Your judgment call:** Try refreshing a non-`@RefreshScope` value — confirm it does NOT change
until restart. Why?

---

## Step 4: Encrypt a Secret (10 min)

> "Configure an encryption key on the Config Server, encrypt the payer `api-key` via `/encrypt`,
> store it as `{cipher}...` in the repo, and confirm the client receives the decrypted value."

---

## You'll know it worked when:

- [ ] The Config Server serves per-service, per-profile config from Git
- [ ] `prior-auth-intake` boots from central config
- [ ] A flag change + `/actuator/refresh` updates a `@RefreshScope` bean live
- [ ] A `{cipher}` secret is stored encrypted and delivered decrypted
