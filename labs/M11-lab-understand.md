# M11 Lab — Understand It Path

> **Module:** M11 · API Documentation
> **Track:** Building REST APIs
> **Time:** ~30 minutes

---

## Goal

See how an accurate, interactive API reference comes straight from your code — and how
annotations turn an accurate spec into a *useful* one for the Prior Authorization API.

---

## Part 1: Read the Code (10 min)

```java
@Operation(summary = "Submit a prior authorization",
           description = "Creates a new prior-auth request in PENDING status")
@ApiResponse(responseCode = "201", description = "Created")
@ApiResponse(responseCode = "400", description = "Validation failed",
             content = @Content(schema = @Schema(implementation = ProblemDetail.class)))
@ApiResponse(responseCode = "409", description = "Duplicate active authorization")
@PostMapping
public ResponseEntity<PriorAuthResponse> submit(@Valid @RequestBody SubmitPriorAuthRequest body) { ... }
```

**Questions to answer:**

1. springdoc could already infer the path, verb, request body, and `PriorAuthResponse` from the
   code. What do the `@Operation` and `@ApiResponse` annotations add that it *couldn't* infer?
2. The `400` response points its schema at `ProblemDetail`. Why is that consistent with M10?
3. At which two URLs does springdoc publish the spec and the UI?
4. If you rename `submit` or change its mapping, what happens to the docs — and why is that the
   key advantage over a wiki page?

---

## Part 2: Spec vs UI (10 min)

| Question | Answer |
|----------|--------|
| Which URL returns machine-readable JSON? | |
| Which URL is the interactive human page? | |
| Which annotation sets the API's title and version? | |
| Which annotation groups endpoints under a heading? | |

---

## Part 3: Predict the Docs (10 min)

Given the `@Schema(example = "M1002934")` on `patientMemberId`:

1. What will Swagger UI pre-fill in the *Try it out* request body for that field?
2. A field has `@NotBlank` but no `@Schema`. Will it still show as required in the docs? Why?
3. You add a new `@ApiResponse(responseCode = "404")`. Where does it appear?
4. Why is a machine-readable `/v3/api-docs` valuable to the API gateway and to client-SDK
   generators (a Track 6 concern)?

---

## You'll know it worked when:

- [ ] You can explain how the spec stays in sync with the code
- [ ] You can name the spec URL vs the UI URL
- [ ] You can say what each documentation annotation contributes
- [ ] You can connect documented errors back to the M10 `ProblemDetail`
