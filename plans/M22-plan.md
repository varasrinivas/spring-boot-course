# M22 Plan — Centralized Configuration

**Track:** Microservices Foundations (key: microservices, color: #a78bfa)
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. The Distributed Config Problem — visual `m22-config-problem` (scattered vs central; from M07 to N services)
2. Spring Cloud Config Server — visual `m22-config-server` (Git → server → clients fetch {app}-{profile})
3. Refresh at Runtime: @RefreshScope — visual `m22-refresh`
4. Securing Config: Encryption & Secrets — visual `m22-config-security` ({cipher}/Vault)

## Coming From Java
Per-service config copied around, env vars per host, no history, plaintext secrets.
Config Server: one versioned source, fetched by clients, refreshable, encrypted.

## Code
- @EnableConfigServer + git uri; client config.import
- @RefreshScope + @Value + /actuator/refresh
- {cipher} encrypted value

## SVG
- config-problem 640×260, config-server 640×270, refresh 640×250, config-security 640×250
