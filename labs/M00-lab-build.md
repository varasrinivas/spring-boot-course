# M00 Lab — Build It with AI Path

> **Module:** M00 · Course Orientation & Setup  
> **Track:** Orientation  
> **Time:** ~30 minutes  
> **Requires:** Claude Code, JDK 21

---

## Goal

Use Claude Code to scaffold the Prior Authorization Service project that you'll
build throughout this course. This is your "hello world" with Claude Code
as a development partner.

---

## Step 1: Create the Project (10 min)

Open Claude Code and ask:

> "Create a new Spring Boot 3.3 project called `prior-auth-service` using
> Maven, JDK 21, with these starters: spring-boot-starter-web,
> spring-boot-starter-data-jpa, spring-boot-starter-validation.
> Use the package `com.payer.priorauth`. Generate the pom.xml and main
> application class."

**Review what Claude generates:**
- Is the Spring Boot version 3.3.x?
- Is the Java version set to 21?
- Are all three starters present?

---

## Step 2: Add the Domain Model (10 min)

Ask Claude Code:

> "Create a PriorAuthRequest record class (not entity yet) with fields: authNumber
> (String), requestDate (LocalDate), status (AuthStatus enum with values
> PENDING, APPROVED, DENIED, EXPIRED), priority (Priority enum: ROUTINE, URGENT),
> patientMemberId (String), providerNpi (String), cptCode (String),
> description (String). Put it in com.payer.priorauth.domain."

**Your judgment:** Does Claude use a Java `record` or a regular `class`?
For now, a record is fine — we'll convert to a JPA entity in Track 4.

---

## Step 3: Run It (10 min)

```powershell
cd prior-auth-service
.\mvnw spring-boot:run
```

Open `http://localhost:8080/actuator/health` — you should see `{"status":"UP"}`.

If it fails, ask Claude Code to diagnose and fix the error.

---

## You'll know it worked when:

- [ ] The project compiles with `.\mvnw compile`
- [ ] The app starts on port 8080
- [ ] `/actuator/health` returns UP
- [ ] You have a PriorAuthRequest domain class in `com.payer.priorauth.domain`
