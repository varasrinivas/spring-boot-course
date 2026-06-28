# M33 Lab — Build It with AI Path

> **Module:** M33 · Docker for Spring Boot
> **Track:** Containerization & Deployment
> **Time:** ~50 minutes
> **Requires:** Claude Code, JDK 21, Docker

---

## Goal

Containerize a prior-auth service three ways — multi-stage Dockerfile, layered, and buildpack —
and compare image size and rebuild speed.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform\prior-auth-review
claude
```

---

## Step 1: Multi-Stage Dockerfile (15 min)

Ask Claude Code:

> "Write a multi-stage Dockerfile for `prior-auth-review`: a JDK build stage that runs `mvnw
> package`, and a slim JRE runtime stage that copies only the jar. Build and run it."

```powershell
docker build -t prior-auth-review:plain .
docker images prior-auth-review:plain      # note the size
docker run -p 8083:8083 prior-auth-review:plain
```

---

## Step 2: Layered JAR (15 min)

> "Enable Spring Boot layered jars, extract the layers, and rewrite the Dockerfile to COPY them
> least-changed first. Change one line of Java and rebuild; show that only the application layer
> rebuilds."

**Your judgment call:** Time the rebuild after a code change for the plain vs layered image.
Which is faster, and why?

---

## Step 3: Buildpacks & Jib (15 min)

> "Build the same service image with `./mvnw spring-boot:build-image` and again with Jib. Compare
> the resulting image sizes and confirm they run as a non-root user."

```powershell
.\mvnw spring-boot:build-image
docker run --rm prior-auth-review:1.0 whoami   # not root
```

---

## Step 4: Reflect (5 min)

- [ ] Which method produced the smallest image? The fastest rebuild?
- [ ] Which would you standardize on across the fleet, and why?
- [ ] What makes this image safe to run identically in prod?

---

## You'll know it worked when:

- [ ] A multi-stage image builds and runs the service
- [ ] A code change rebuilds only the app layer with layered JARs
- [ ] A buildpack image runs as non-root with no Dockerfile
- [ ] You can compare sizes and rebuild times across methods
