# M10 Plan — Request Validation & Error Handling

**Track:** Building REST APIs (key: rest, color: #2dd4bf)
**Level:** Intermediate
**Status:** ✅ BUILT

## Concepts

1. **Bean Validation with @Valid**
   - Visual: `m10-constraints` — annotated DTO fields (@NotBlank/@Pattern/@Min) + @Valid trigger
   - Code: SubmitPriorAuthRequest constraints + @Valid @RequestBody
   - Key point: declare rules on the DTO; @Valid enforces them before the handler runs

2. **Validation Failure → Exception → Default 400**
   - Visual: `m10-valid-flow` — @Valid gate: valid → handler (2xx); invalid → exception → 400;
     @RequestBody → MethodArgumentNotValidException, @PathVariable/@RequestParam → ConstraintViolationException
   - Key point: a failed @Valid throws and Spring returns 400 by default

3. **Centralized Handling: @RestControllerAdvice / @ExceptionHandler**
   - Visual: `m10-controller-advice` — exceptions from many controllers funnel into one advice → responses
   - Code: @RestControllerAdvice mapping NotFound→404, Duplicate→409
   - Key point: one place maps exceptions to HTTP responses; no try/catch per handler

4. **ProblemDetail (RFC 7807): Standard Error Bodies**
   - Visual: `m10-problemdetail` — anatomy of application/problem+json (type/title/status/detail/instance/+custom)
   - Code: building a ProblemDetail with custom properties
   - Key point: one machine-readable error format across the whole API

## Coming From Java Angle

Manual: scattered if-checks in controllers, ad hoc throw/catch, hand-built error JSON that
differs per endpoint, try/catch in every method. Spring: declarative constraints, automatic
validation, one advice, standard ProblemDetail.

## Code Examples

- SubmitPriorAuthRequest constraints + @Valid (~10 lines)
- @RestControllerAdvice with @ExceptionHandler → ProblemDetail (~12 lines)
- ProblemDetail with custom properties (~6 lines)

## SVG Diagrams

- constraints: 640×260, annotated DTO + @Valid trigger
- valid-flow: 640×270, validation gate valid/invalid branches + exception sources
- controller-advice: 640×280, exception funnel → mapped responses
- problemdetail: 640×280, problem+json anatomy
