# M11 Lab — Build It with AI Path

> **Module:** M11 · API Documentation
> **Track:** Building REST APIs
> **Time:** ~45 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Give the Prior Authorization API a complete, interactive OpenAPI reference: add springdoc,
customize the metadata, and enrich endpoints and models with annotations — then explore it all
in Swagger UI. Claude Code wires it; you judge whether the docs are actually usable.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: Add springdoc & Explore (10 min)

Ask Claude Code:

> "Add `springdoc-openapi-starter-webmvc-ui`. Start the app and confirm the spec is at
> `/v3/api-docs` and Swagger UI at `/swagger-ui.html`."

```powershell
curl http://localhost:8080/v3/api-docs | ConvertFrom-Json | Select-Object -ExpandProperty paths
# then open Swagger UI in a browser
Start-Process "http://localhost:8080/swagger-ui.html"
```

**Review:** Every endpoint from M09/M10 should already appear, with schemas, *before* you add a
single annotation. Note what's missing or unclear.

---

## Step 2: Title & Operation Docs (15 min)

> "Add an `OpenAPI` bean with title 'Prior Authorization API', version '1.0', and a description.
> Then annotate each `PriorAuthController` method with `@Operation` (summary + description) and
> `@ApiResponse` entries for its real status codes — including `400`/`404`/`409` pointing at
> `ProblemDetail`. Group them under a `@Tag(\"prior-auths\")`."

Reload Swagger UI and confirm the summaries, tag heading, and documented error responses appear.

---

## Step 3: Document the Models (15 min)

> "Add `@Schema` to `SubmitPriorAuthRequest` and `PriorAuthResponse` fields with descriptions and
> realistic `example` values (member ID `M1002934`, NPI `1083948272`, CPT `70553`). Then use
> Swagger UI's *Try it out* to submit a request using the pre-filled example."

**Your judgment call:** Could a developer from another team submit a valid prior-auth using only
the docs — no Slack questions? If not, what example or description is still missing?

---

## Step 4: Reflect (5 min)

- [ ] What did springdoc generate for free, and what required annotations?
- [ ] How do your M10 `ProblemDetail` errors now show up in the docs?
- [ ] Why will these docs never go stale the way a wiki page would?

---

## You'll know it worked when:

- [ ] Swagger UI lists every endpoint with summaries and documented responses
- [ ] The API has a real title/version, and endpoints are grouped under a tag
- [ ] Request models show descriptions and example values
- [ ] You submitted a request from *Try it out* using the example body
