# M09 Lab — Build It with AI Path

> **Module:** M09 · REST Controllers
> **Track:** Building REST APIs
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Build the full REST surface for the Prior Authorization resource — collection and item, all the
verbs, correct status codes — with Claude Code, then exercise it with real HTTP calls. (Error
handling is intentionally left for M10.)

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: The Resource Controller (15 min)

Ask Claude Code:

> "Create a `@RestController` `PriorAuthController` at base path `/api/prior-auths` backed by
> `PriorAuthService`. Add `SubmitPriorAuthRequest` (input) and `PriorAuthResponse` (output)
> records. Implement: `GET` list (optional `status` query param), `GET /{authNumber}`,
> `POST` submit returning `201 Created` with a `Location` header, `PATCH /{authNumber}/decision`
> to approve/deny, and `DELETE /{authNumber}` returning `204`."

**Review before accepting:**
- Does `POST` return `201` with a `Location`, not `200`?
- Does `DELETE` return `204 No Content`?
- Are input and output modeled as separate records (not the entity)?

---

## Step 2: Exercise the API (15 min)

```powershell
# create
curl -X POST http://localhost:8080/api/prior-auths -H "Content-Type: application/json" `
  -d '{"patientMemberId":"M1002934","providerNpi":"1083948272","cptCode":"70553"}' -i

# list + filter
curl "http://localhost:8080/api/prior-auths?status=PENDING"

# read one (use the authNumber from the create response)
curl http://localhost:8080/api/prior-auths/PA-2026-000123

# withdraw
curl -X DELETE http://localhost:8080/api/prior-auths/PA-2026-000123 -i
```

**Verify with the `-i` flag:** confirm the status line is `201` on create (with `Location`) and
`204` on delete.

---

## Step 3: A Decision Endpoint (15 min)

> "Implement `PATCH /api/prior-auths/{authNumber}/decision` taking a `{ \"decision\":
> \"APPROVED\" | \"DENIED\", \"reason\": \"...\" }` body, returning `200 OK` with the updated
> `PriorAuthResponse`. Keep all business rules in `PriorAuthService`."

Approve one and confirm the returned `status` changed.

---

## Step 4: Reflect (5 min)

- [ ] Which handlers return `ResponseEntity` and which return the object directly? Why?
- [ ] Where did you resist putting business logic, and where did it belong?
- [ ] Which responses still need real error handling (the `4xx` cases) — your M10 to-do list?

---

## You'll know it worked when:

- [ ] All five+ endpoints respond, with correct 2xx codes verified via `curl -i`
- [ ] `POST` returns `201` + `Location`; `DELETE` returns `204`
- [ ] Input and output use distinct DTO records, not the entity
- [ ] The controller stays thin; logic lives in `PriorAuthService`
