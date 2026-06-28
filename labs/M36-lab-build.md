# M36 Lab — Build It with AI Path

> **Module:** M36 · CI/CD Pipeline
> **Track:** Containerization & Deployment
> **Time:** ~60 minutes
> **Requires:** Claude Code, JDK 21, Docker, a GitHub repo, a cluster (kind/minikube)

---

## Goal

Build a full pipeline for `prior-auth-review`: GitHub Actions builds and tests (with
Testcontainers), pushes a SHA-tagged image, and rolls it out to Kubernetes — the capstone of the
course.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
```

---

## Step 1: CI with Testcontainers (20 min)

Ask Claude Code:

> "Add an integration test for `prior-auth-review` using Testcontainers + a real
> `PostgreSQLContainer`, wired with `@DynamicPropertySource`. Then write
> `.github/workflows/ci.yml` that checks out, sets up JDK 21, and runs `./mvnw -B verify` on push
> and PR."

Push a branch and open a PR; confirm the workflow runs the tests (including the container-backed
integration test) and gates the merge.

---

## Step 2: Build & Push the Image (15 min)

> "Add a `package` job (needs: build) that builds the image with `spring-boot:build-image` tagged
> `ghcr.io/<me>/prior-auth-review:${{ github.sha }}` and pushes it to GitHub Container Registry."

**Review:** Is the image tagged by commit SHA (not just `latest`)?

---

## Step 3: Rolling Deploy (20 min)

> "Add a `deploy` job (needs: package) that runs `kubectl set image
> deployment/prior-auth-review review=...:${{ github.sha }}` against the cluster and waits for
> `kubectl rollout status`. Use the readiness probe so the rollout is zero-downtime."

**Your judgment call:** Push a change while curling the Service in a loop. Did any request fail
during the rollout? Then push an intentionally-broken image and confirm the rollout is held back
(it never passes readiness) rather than taking the service down.

---

## Step 4: Reflect — the whole journey (5 min)

- [ ] Trace a one-line change from `git push` to running in the cluster. Name every stage.
- [ ] Which earlier-module features made the deploy *safe*?
- [ ] How would you roll back? (Hint: the previous SHA tag.)
- [ ] You've built a complete platform. What would you add next for *your* domain?

---

## You'll know it worked when:

- [ ] CI builds and runs Testcontainers integration tests on every push/PR
- [ ] A SHA-tagged image is pushed to the registry
- [ ] The pipeline rolls the new image out to Kubernetes with zero downtime
- [ ] A broken image is held back by the readiness gate, not deployed
- [ ] 🎉 You can deploy the Prior Authorization platform from commit to cluster, automatically
