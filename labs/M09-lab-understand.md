# M09 Lab — Understand It Path

> **Module:** M09 · REST Controllers
> **Track:** Building REST APIs
> **Time:** ~30 minutes

---

## Goal

Get fluent reading a REST controller: what each verb maps to, how request data binds, and which
status code each outcome deserves — for the Prior Authorization Service API.

---

## Part 1: Read the Code (10 min)

```java
@RestController
@RequestMapping("/api/prior-auths")
public class PriorAuthController {
    private final PriorAuthService service;
    public PriorAuthController(PriorAuthService service) { this.service = service; }

    @GetMapping
    public List<PriorAuthResponse> list(@RequestParam(required=false) Status status) {
        return service.findAll(status);
    }

    @PostMapping
    public ResponseEntity<PriorAuthResponse> submit(@RequestBody SubmitPriorAuthRequest body) {
        PriorAuthResponse created = service.submit(body);
        URI location = URI.create("/api/prior-auths/" + created.authNumber());
        return ResponseEntity.created(location).body(created);
    }
}
```

**Questions to answer:**

1. What full URL and verb does `list(...)` handle? What does `?status=PENDING` bind to?
2. `submit(...)` returns `201 Created`. What is in the `Location` header, and why is that useful
   to the client?
3. Why does the API accept a `SubmitPriorAuthRequest` but return a `PriorAuthResponse` instead of
   reusing one type for both?
4. Where is the `@ResponseBody` that turns these return values into JSON? (Hint: M04.)

---

## Part 2: Match Verb → Outcome (10 min)

Fill in the expected status code for each call:

| Request | Status | Body? |
|---------|--------|-------|
| `GET /api/prior-auths` | | |
| `GET /api/prior-auths/PA-1` (exists) | | |
| `POST /api/prior-auths` (valid) | | |
| `DELETE /api/prior-auths/PA-1` (withdraw) | | |

---

## Part 3: Predict & Verify (10 min)

| Scenario | Your Prediction |
|----------|-----------------|
| `GET /api/prior-auths/PA-999` where PA-999 doesn't exist — what *should* it return? | |
| `POST` with a malformed JSON body — what status class? | |
| Calling `DELETE` twice on the same item — is the verb idempotent? | |
| Which of these endpoints' handling is actually deferred to M10? | |

---

## You'll know it worked when:

- [ ] You can read any handler and state its verb, URL, and bound parameters
- [ ] You can pick the right 2xx status for create/read/update/withdraw
- [ ] You can explain why `201` includes a `Location` header
- [ ] You can explain the request-DTO vs response-DTO split
