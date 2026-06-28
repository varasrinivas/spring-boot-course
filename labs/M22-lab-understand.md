# M22 Lab — Understand It Path

> **Module:** M22 · Centralized Configuration
> **Track:** Microservices Foundations
> **Time:** ~30 minutes

---

## Goal

Understand how a Config Server gives the prior-auth fleet one versioned source of truth, with
runtime refresh and encrypted secrets.

---

## Part 1: Read the Config (10 min)

```yaml
# config-server
spring.cloud.config.server.git.uri: https://github.com/payer/prior-auth-config

# prior-auth-intake (client)
spring:
  application: { name: prior-auth-intake }
  config:
    import: optional:configserver:http://config-server:8888
```

**Questions:**

1. When `prior-auth-intake` starts with profile `prod`, which file(s) does the server return?
2. Why store the configuration in Git rather than in each service?
3. The payer URL changes. With centralized config, how many places do you edit?
4. What does `@RefreshScope` let you do that plain `@Value` cannot?

---

## Part 2: Refresh vs Restart (10 min)

| Setting | @RefreshScope can update live? | Why |
|---------|-------------------------------|-----|
| `priorauth.features.auto-approve` | | |
| `spring.datasource.url` | | |
| a request timeout | | |

What broadcasts a single refresh to every running instance?

---

## Part 3: Secrets (10 min)

| Question | Your Answer |
|----------|-------------|
| What does the `{cipher}` prefix mean, and who decrypts it? | |
| Why is ciphertext-in-Git acceptable but plaintext is not? | |
| When would you back the server with Vault instead? | |
| What protects the value in transit from server to client? | |

---

## You'll know it worked when:

- [ ] You can trace a client fetching its config by name + profile
- [ ] You can explain config-as-versioned-code
- [ ] You can say what `@RefreshScope` refreshes and what it doesn't
- [ ] You can describe how secrets stay protected
