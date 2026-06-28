# M20 Lab — Build It with AI Path

> **Module:** M20 · Method-Level Security
> **Track:** Spring Security
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Add per-method and per-object authorization to the Prior Authorization Service and lock it in
with security tests.

---

## Setup

```powershell
cd C:\Projects\prior-auth-service
claude
```

---

## Step 1: Enable & Annotate (15 min)

Ask Claude Code:

> "Add `@EnableMethodSecurity`. Annotate `PriorAuthService.decide` with
> `@PreAuthorize(\"hasRole('REVIEWER')\")` and `submit` with
> `@PreAuthorize(\"hasAuthority('SCOPE_prior-auth:write')\")`. Make sure a 403 surfaces as a
> ProblemDetail (reuse the M10 advice)."

**Review:** Are the annotations on the service methods (so they hold regardless of caller)?

---

## Step 2: Object-Level Ownership (15 min)

> "Add an `Assignments` `@Component` with `isAssignedTo(authNumber, username)`. Change `decide`'s
> rule to `hasRole('REVIEWER') and @assignments.isAssignedTo(#authNumber, authentication.name)`.
> Seed two reviewers and assignments so I can test ownership."

Test that reviewer A cannot decide an auth assigned to reviewer B.

---

## Step 3: Security Tests (15 min)

> "Add `spring-security-test`. Write `@WebMvcTest`/`@SpringBootTest` cases with `@WithMockUser`:
> REVIEWER decides assigned → 200; REVIEWER decides unassigned → 403; SUBMITTER decides → 403;
> SUBMITTER submits → 200; anonymous → 401. Run them."

```powershell
.\mvnw test -Dtest="*SecurityTest"
```

**Your judgment call:** Did any negative case unexpectedly pass? That's the bug method security
exists to prevent.

---

## Step 4: Reflect (5 min)

- [ ] Which rules belong at the URL layer vs the method layer, and why both?
- [ ] How did object-level ownership change the rule's shape?
- [ ] Which test caught the most subtle mistake?

---

## You'll know it worked when:

- [ ] Role rules enforce on the service methods (403 on violation)
- [ ] Ownership: a reviewer can only decide their assigned auths
- [ ] The full role × operation test matrix passes, negatives included
- [ ] A 403 returns a ProblemDetail body
