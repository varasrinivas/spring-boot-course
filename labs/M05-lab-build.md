# M05 Lab — Build It with AI Path

> **Module:** M05 · Your First Spring Boot App
> **Track:** Spring Boot Essentials
> **Time:** ~45 minutes
> **Requires:** Claude Code, JDK 21, IDE

---

## Goal

Generate, run, and package the Prior Authorization Service as a real Spring Boot app — then
prove to yourself it's a single self-contained executable. Claude Code drives the tooling; you
verify each automation actually happened.

---

## Setup

```powershell
cd C:\Projects
claude
```

---

## Step 1: Generate the Project (10 min)

Ask Claude Code:

> "Generate a Spring Boot 3.3 project `prior-auth-service` (Maven, Java 21, group
> `com.payer`) with the `web`, `data-jpa`, and `validation` starters — either by calling
> start.spring.io or scaffolding the files directly. Show me the resulting directory tree and
> the `pom.xml`."

**Review before accepting:**
- Is there exactly one `@SpringBootApplication` class, and is it in the **root** package?
- Does `pom.xml` inherit from `spring-boot-starter-parent` (managed versions)?
- Are all three starters present and free of explicit version numbers?

---

## Step 2: Run It & Read the Logs (10 min)

```powershell
cd prior-auth-service
.\mvnw spring-boot:run
```

Find these lines in the startup log and note them:
- The banner / Spring Boot version
- `Tomcat initialized with port 8080`
- `Started PriorAuthServiceApplication in X seconds`

Open `http://localhost:8080/actuator/health` (ask Claude to add `spring-boot-starter-actuator`
if it's not there). You should see `{"status":"UP"}`.

---

## Step 3: Package the Fat JAR (15 min)

> "Build the executable JAR and show me what's inside it that makes it self-contained."

```powershell
.\mvnw clean package
java -jar target\prior-auth-service-0.0.1-SNAPSHOT.jar
```

Then inspect it:

```powershell
jar tf target\prior-auth-service-0.0.1-SNAPSHOT.jar | Select-String "tomcat|BOOT-INF|MANIFEST"
```

Ask Claude Code: *"Explain what BOOT-INF/lib contains and what the Main-Class in the manifest
points to."*

---

## Step 4: Reflect (10 min)

- [ ] How many lines of configuration did you write to get a serving HTTP app? Where did the
      DispatcherServlet come from?
- [ ] What in the fat JAR makes `java -jar` work with no external server?
- [ ] Which Track 1 mechanisms are still doing their job inside this Boot app?

---

## You'll know it worked when:

- [ ] `mvnw spring-boot:run` starts the app on port 8080
- [ ] `/actuator/health` returns UP
- [ ] The packaged JAR runs standalone with `java -jar`
- [ ] You found Tomcat and `BOOT-INF/` inside the JAR and can explain why they're there
