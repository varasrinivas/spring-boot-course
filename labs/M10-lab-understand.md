# M10 Lab — Understand It Path

> **Module:** M10 · Request Validation & Error Handling
> **Track:** Building REST APIs
> **Time:** ~30 minutes

---

## Goal

Understand how invalid input becomes a clean, standard error response — from constraint to
exception to `@RestControllerAdvice` to a `ProblemDetail` body.

---

## Part 1: Read the Code (10 min)

```java
public record SubmitPriorAuthRequest(
        @NotBlank String patientMemberId,
        @Pattern(regexp = "\\d{10}") String providerNpi,
        @Pattern(regexp = "\\d{5}")  String cptCode,
        @Min(1) int units) { }

@PostMapping
public ResponseEntity<PriorAuthResponse> submit(
        @Valid @RequestBody SubmitPriorAuthRequest body) { ... }

@RestControllerAdvice
public class ApiExceptionHandler {
    @ExceptionHandler(PriorAuthNotFoundException.class)
    public ProblemDetail handleNotFound(PriorAuthNotFoundException ex) {
        ProblemDetail pd = ProblemDetail.forStatusAndDetail(HttpStatus.NOT_FOUND, ex.getMessage());
        pd.setTitle("Prior authorization not found");
        return pd;
    }
}
```

**Questions to answer:**

1. A client POSTs `{ "patientMemberId": "", "providerNpi": "12", "cptCode": "70553", "units": 0 }`.
   Which **three** constraints fail, and what does each require?
2. What exception does that failed `@Valid @RequestBody` throw, and what status results by default?
3. If `submit` is called with valid input but the service throws `PriorAuthNotFoundException`,
   which method handles it and what status is returned?
4. Why does the controller method body not contain any `try/catch`?

---

## Part 2: Exception → Response Map (10 min)

Complete the table the advice (and Spring defaults) produce:

| Situation | Exception | Status |
|-----------|-----------|--------|
| Blank `patientMemberId` | | |
| `authNumber` doesn't exist | | |
| Duplicate active authorization | | |
| `@PathVariable` fails a constraint | | |

---

## Part 3: Read a ProblemDetail (10 min)

```json
{
  "type": "https://errors.payer.com/validation",
  "title": "Invalid prior-auth request",
  "status": 400,
  "detail": "One or more fields are invalid",
  "instance": "/api/prior-auths",
  "errors": { "providerNpi": "must be 10 digits", "units": "must be at least 1" }
}
```

1. What is the `Content-Type` of this response?
2. Which fields are RFC 7807 standard, and which is custom?
3. Why is a standard error format valuable when the API gateway and other services call this API?

---

## You'll know it worked when:

- [ ] You can predict which constraints fail for a given body
- [ ] You can name the exception per validation source and the default status
- [ ] You can trace a domain exception to its `@ExceptionHandler` and status
- [ ] You can read a `problem+json` body and identify standard vs custom fields
