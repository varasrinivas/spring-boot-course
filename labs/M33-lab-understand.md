# M33 Lab — Understand It Path

> **Module:** M33 · Docker for Spring Boot
> **Track:** Containerization & Deployment
> **Time:** ~30 minutes

---

## Goal

Understand container images, multi-stage builds, layered caching, and Dockerfile-free builds.

---

## Part 1: Read the Dockerfile (10 min)

```dockerfile
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app
COPY . .
RUN ./mvnw -q clean package -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/prior-auth-review-*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
```

**Questions:**

1. Why two `FROM` stages? What from the build stage does NOT end up in the shipped image?
2. The runtime base is `-jre`, not `-jdk`. Why does that matter?
3. You change one line of Java. With a single-layer fat JAR copy, how much of the image rebuilds?
   With layered JARs, how much?
4. What does a buildpack (`spring-boot:build-image`) give you that this Dockerfile doesn't, for free?

---

## Part 2: Image Hygiene (10 min)

| Practice | Why it matters |
|----------|----------------|
| JRE (not JDK) runtime base | |
| Multi-stage build | |
| Layered JAR ordering | |
| Non-root user | |

---

## Part 3: Predict (10 min)

| Question | Your Answer |
|----------|-------------|
| Same image, two environments — why no "works on my machine"? | |
| Why is the image immutable and versioned like a release artifact? | |
| Buildpacks vs Jib vs hand-written Dockerfile — when each? | |
| What's the deployable unit Compose (M34) and K8s (M35) will use? | |

---

## You'll know it worked when:

- [ ] You can explain image vs container and the benefits
- [ ] You can justify the multi-stage split
- [ ] You can explain layered-JAR caching
- [ ] You can choose a build method
