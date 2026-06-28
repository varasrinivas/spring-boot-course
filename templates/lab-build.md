# MXX Lab — Build It with AI Path

> **Module:** MXX · Module Title  
> **Track:** Track Label  
> **Time:** ~45 minutes  
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Build [FEATURE] for the Prior Authorization Service using Claude Code as your pair programmer.
You drive the design decisions; Claude Code handles the boilerplate.

---

## Setup

```powershell
# Navigate to your project
cd C:\Projects\ucc-filing-service

# Start Claude Code
claude
```

---

## Step 1: Scaffold (10 min)

Ask Claude Code:

> "Create [COMPONENT] for the Prior Authorization Service. The PriorAuthRequest entity has:
> authNumber (String), requestDate (LocalDate),
> status (enum: PENDING, APPROVED, DENIED, EXPIRED), patientMemberId (String),
> providerNpi (String), cptCode (String), description (String)."

**Review what Claude generates.** Before accepting:
- Does the package structure match your project?
- Are the annotations correct per Module XX?
- Could you explain every line to a teammate?

---

## Step 2: Customize (15 min)

Now extend it with domain-specific logic:

> "[SPECIFIC_EXTENSION_PROMPT — e.g., Add validation that authNumber
> must match pattern PA-[YYYY]-[NNNNNN]. Add a custom exception
> for a duplicate active request for the same patient and CPT code.]"

**Your judgment call:** Does Claude's implementation match what you learned
in the module? If not, tell it what to change and why.

---

## Step 3: Test (10 min)

Ask Claude Code:

> "Write integration tests for [COMPONENT] using @SpringBootTest and
> MockMvc. Test the happy path and at least two error scenarios
> (invalid filing number format, duplicate filing)."

Run the tests:

```powershell
.\mvnw test -pl ucc-filing-service -Dtest="[TestClassName]"
```

---

## Step 4: Reflect (10 min)

Answer honestly:
- [ ] Could you build this without Claude Code? What parts?
- [ ] What did Claude Code get wrong that you had to correct?
- [ ] What Spring concept from Module XX did you use that you didn't know before?

---

## You'll know it worked when:

- [ ] Your feature compiles and passes tests
- [ ] You made at least one design decision that overrode Claude's suggestion
- [ ] You can explain the Spring annotations used without looking them up
