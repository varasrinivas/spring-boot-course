# M25 Lab — Build It with AI Path

> **Module:** M25 · Synchronous Communication
> **Track:** Inter-Service Communication
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21

---

## Goal

Have `prior-auth-review` call `eligibility-service` synchronously via a declarative,
load-balanced client with proper timeouts and error handling.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: A Load-Balanced RestClient (15 min)

Ask Claude Code:

> "In `prior-auth-review`, add a `@LoadBalanced RestClient.Builder` and a method that calls
> `http://eligibility-service/api/eligibility/{member}` and returns an `Eligibility`. Use it in
> `decide` so a not-covered member is denied."

```powershell
curl -X PATCH http://localhost:8080/api/prior-auths/PA-1/decision -d '{"decision":"APPROVED"}'
```

**Review:** Is the call by service name (no host:port)?

---

## Step 2: Make It Declarative (10 min)

> "Refactor to a `@HttpExchange` `EligibilityClient` interface backed by the load-balanced
> RestClient, and inject it into the service. Show the call site reading like a local method."

---

## Step 3: Timeouts & Errors (15 min)

> "Configure 2s connect / 3s read timeouts on the client and a status handler that throws
> `EligibilityUnavailableException` on error responses (mapped to a ProblemDetail via the M10
> advice). Add a test using a stub that delays beyond the read timeout and assert the call fails
> fast."

**Your judgment call:** With the stub sleeping 10s and a 3s read timeout, how long until `review`
returns? What would happen with no timeout?

---

## Step 4: Reflect (10 min)

- [ ] How does `review` behave when eligibility is down vs slow?
- [ ] Why did the declarative interface make the service code cleaner?
- [ ] What will you add in Track 8 so a struggling eligibility degrades gracefully?

---

## You'll know it worked when:

- [ ] `review` calls `eligibility` by name through discovery
- [ ] The call site uses a declarative interface
- [ ] Connect/read timeouts make a slow call fail fast
- [ ] Error responses map to a clean domain exception
