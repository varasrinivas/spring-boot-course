# M05 Lab — Understand It Path

> **Module:** M05 · Your First Spring Boot App
> **Track:** Spring Boot Essentials
> **Time:** ~30 minutes

---

## Goal

Connect everything from Track 1 to what Boot automates. By the end you'll be able to explain
exactly what `@SpringBootApplication` does and why the result runs with `java -jar`.

---

## Part 1: Read the Code (10 min)

```java
package com.payer.priorauth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class PriorAuthServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(PriorAuthServiceApplication.class, args);
    }
}
```

**Questions to answer:**

1. `@SpringBootApplication` stands for which three annotations, and what does each do?
2. This class is in package `com.payer.priorauth`. Why does its *location* matter for component
   scanning — what would happen if you moved it to `com.payer.priorauth.web`?
3. `SpringApplication.run(...)` does four things at startup. Name them.
4. Which Track 1 concept is responsible for `PriorAuthService` getting injected into a
   controller in this Boot app? (Boot didn't replace it — it's the same mechanism.)

---

## Part 2: Map Manual → Automated (10 min)

For each manual core-Spring step, write what Boot does instead:

| Core Spring (manual) | Spring Boot (automated) |
|----------------------|--------------------------|
| Choose & configure Tomcat | |
| Register the DispatcherServlet | |
| Pick compatible library versions | |
| Package & deploy a WAR to a server | |

---

## Part 3: Predict & Verify (10 min)

| Question | Your Answer |
|----------|-------------|
| Which starter brings the embedded server and the DispatcherServlet? | |
| Where do you set the server port, and what's the default? | |
| What's inside the fat JAR that a plain JAR would not contain? | |
| Run `java -jar target/...jar` — what line in the logs tells you Tomcat started, and on which port? | |

---

## You'll know it worked when:

- [ ] You can expand `@SpringBootApplication` into its three parts from memory
- [ ] You can explain why the main class lives in the root package
- [ ] You can map each manual setup step to its Boot automation
- [ ] You can explain why a Boot app needs no externally installed server
