# M04 Lab — Build It with AI Path

> **Module:** M04 · Spring MVC Fundamentals
> **Track:** Spring Core Fundamentals
> **Time:** ~45 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Build a Prior Authorization controller two ways — once returning a view, once returning JSON —
so you feel exactly where Spring MVC forks. Claude Code handles the scaffolding; you make the
mapping and response-type decisions.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

> Need a view template engine for Step 1? Ask Claude to add `spring-boot-starter-thymeleaf`.

---

## Step 1: A View-Returning Controller (15 min)

Ask Claude Code:

> "Create a `@Controller PriorAuthViewController` mapped to `/prior-auths`. Add a
> `@GetMapping(\"/{authNumber}\")` handler that takes a `@PathVariable String authNumber`, an
> optional `@RequestParam String tab`, and a `Model`, looks up the request via
> `PriorAuthService`, adds it as a model attribute, and returns the view name
> `prior-auth-detail`. Create a minimal Thymeleaf `prior-auth-detail.html` that prints the
> auth number and status."

**Review before accepting:**
- Is the return type `String` (a view name), not the entity?
- Is `tab` optional, and does a missing value behave sensibly?
- Run it: `GET /prior-auths/PA-2026-000123` should render HTML.

---

## Step 2: The Same Data as JSON (10 min)

> "Add a second handler `viewJson` at `/{authNumber}/json` annotated with `@ResponseBody` that
> returns the `PriorAuthRequest` object directly. Then explain what Spring does differently for
> this method versus the view-returning one."

**Your judgment call:** Hit both endpoints in a browser / `curl`. One returns HTML, one returns
JSON. Ask Claude: *which components are skipped on the `@ResponseBody` path, and why?*

---

## Step 3: Collapse to @RestController (10 min)

> "Create a separate `@RestController PriorAuthApiController` at `/api/prior-auths` with a
> `@GetMapping(\"/{authNumber}\")` returning the `PriorAuthRequest`. Show that no method needs
> `@ResponseBody` here, and explain why."

Confirm the `/api/...` endpoint returns JSON with no `@ResponseBody` anywhere.

---

## Step 4: Reflect (10 min)

- [ ] What is the *only* difference between your `@Controller` + `@ResponseBody` method and the
      `@RestController` version?
- [ ] Trace a `GET /api/prior-auths/PA-1` request aloud through the MVC lifecycle.
- [ ] Which parts of all this will Spring Boot auto-configure for you in Track 2 (so you write
      none of the servlet setup)?

---

## You'll know it worked when:

- [ ] The view endpoint renders HTML; the JSON endpoints return serialized objects
- [ ] You demonstrated the same data flowing through both MVC forks
- [ ] You can explain `@RestController` in one sentence
- [ ] You can name what the DispatcherServlet orchestrates without notes
