# M35 Lab — Build It with AI Path

> **Module:** M35 · Kubernetes Essentials
> **Track:** Containerization & Deployment
> **Time:** ~60 minutes
> **Requires:** Claude Code, JDK 21, a local cluster (kind/minikube/Docker Desktop)

---

## Goal

Deploy a prior-auth service to a local Kubernetes cluster with a Deployment, Service,
ConfigMap/Secret, and probes — then watch it self-heal and roll out an update.

---

## Setup

```powershell
cd C:\Projects\prior-auth-platform
claude
# enable Kubernetes in Docker Desktop, or: kind create cluster
```

---

## Step 1: Deployment + Service (20 min)

Ask Claude Code:

> "Write `k8s/review-deployment.yaml` (3 replicas of `payer/prior-auth-review:1.0`) and
> `k8s/review-service.yaml`. Apply them and confirm 3 pods and a reachable Service."

```powershell
kubectl apply -f k8s/
kubectl get pods,svc
kubectl port-forward svc/prior-auth-review 8083:80
```

---

## Step 2: Config & Secrets (15 min)

> "Add a `ConfigMap` (payer base URL) and a `Secret` (payer API key), and wire them into the
> Deployment via `envFrom`. Confirm the app reads them (log the bound values, masking the
> secret)."

**Review:** Is the secret value out of the Deployment manifest?

---

## Step 3: Probes, Healing & Rollout (20 min)

> "Add liveness/readiness probes pointing at the actuator endpoints. Then: (a) delete a pod and
> watch it be recreated; (b) make readiness fail and confirm traffic stops without a restart;
> (c) roll out `:1.1` and watch the zero-downtime update gated on readiness."

```powershell
kubectl delete pod -l app=review --field-selector ...   # one pod
kubectl get pods -w                                     # watch it return
kubectl set image deployment/prior-auth-review review=payer/prior-auth-review:1.1
kubectl rollout status deployment/prior-auth-review
```

**Your judgment call:** During the rollout, hit the Service in a loop — do any requests fail?

---

## Step 4: Reflect (5 min)

- [ ] Which course concepts (config M07/M22, health M32, discovery M23) showed up as K8s features?
- [ ] What did the probes give you operationally?
- [ ] What's left to automate? (→ M36 CI/CD)

---

## You'll know it worked when:

- [ ] 3 pods run behind a Service
- [ ] Config/secrets inject via ConfigMap/Secret, not the image
- [ ] A deleted pod is recreated automatically
- [ ] A `:1.1` rollout completes with zero failed requests
