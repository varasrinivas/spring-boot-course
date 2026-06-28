# M36 Plan — CI/CD Pipeline

**Track:** Containerization & Deployment (key: deployment, color: #34d399) — FINAL MODULE (M36/37)
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. The CI/CD Pipeline: Commit to Cluster — visual `m36-pipeline` (capstone, ties course together)
2. CI: Build & Test with GitHub Actions (+ Testcontainers) — visual `m36-ci`
3. Building & Pushing Images — visual `m36-image-push`
4. CD: Rolling Deploy to Kubernetes — visual `m36-cd`

## Coming From Java
Manual build/copy/SSH-deploy in a maintenance window. CI/CD: automated, tested, zero-downtime, every commit.

## Code
- .github/workflows/ci.yml (checkout/setup-java/mvnw verify)
- Testcontainers @Testcontainers + PostgreSQLContainer + @DynamicPropertySource
- build-image + push (commit SHA tag)
- kubectl set image + rollout status

## SVG
- pipeline 640×260, ci 640×260, image-push 640×250, cd 640×260
NOTE: no ${ or backticks in renderVisual SVG text (use plain words). ${{ github.sha }} ok in JSON code data.
