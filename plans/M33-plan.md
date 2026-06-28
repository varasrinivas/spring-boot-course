# M33 Plan — Docker for Spring Boot

**Track:** Containerization & Deployment (key: deployment, color: #34d399) — START of Track 9
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Containerizing a Spring Boot App — visual `m33-why-containers` (builds on M05 fat JAR)
2. Multi-Stage Dockerfile — visual `m33-multistage`
3. Layered JARs for Caching — visual `m33-layers`
4. Buildpacks & Jib: No Dockerfile — visual `m33-buildpacks`

## Coming From Java
Deploy jar/war to manually provisioned server (drift, snowflakes). Containers: immutable image.

## Code
- multi-stage Dockerfile (jdk build → jre runtime)
- layered extraction Dockerfile
- spring-boot:build-image / jib

## SVG
- why-containers 640×250, multistage 640×260, layers 640×260, buildpacks 640×250
