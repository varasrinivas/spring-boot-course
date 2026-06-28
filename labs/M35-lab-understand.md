# M35 Lab — Understand It Path

> **Module:** M35 · Kubernetes Essentials
> **Track:** Containerization & Deployment
> **Time:** ~30 minutes

---

## Goal

Understand declarative orchestration, the core objects, config/secrets, and probe-driven
self-healing.

---

## Part 1: Read the Manifests (10 min)

```yaml
kind: Deployment
spec:
  replicas: 3
  template:
    spec:
      containers:
        - image: payer/prior-auth-review:1.0
          envFrom: [{ configMapRef: { name: review-config } }, { secretRef: { name: review-secret } }]
          livenessProbe:  { httpGet: { path: /actuator/health/liveness,  port: 8083 } }
          readinessProbe: { httpGet: { path: /actuator/health/readiness, port: 8083 } }
---
kind: Service
spec: { selector: { app: review }, ports: [{ port: 80, targetPort: 8083 }] }
```

**Questions:**

1. One of the three pods crashes. What notices, and what does it do? (Name the loop.)
2. Pods get new IPs as they come and go. How do clients reach review reliably?
3. The payer dependency goes down so readiness fails. Does Kubernetes restart the pod or stop
   routing to it? Why is that the right action (recall M32)?
4. Where do `review-config`/`review-secret` values end up in the Spring app (recall M07)?

---

## Part 2: Object Roles (10 min)

| Object | Role |
|--------|------|
| Pod | |
| Deployment | |
| Service | |
| ConfigMap / Secret | |

---

## Part 3: Updates & Healing (10 min)

| Question | Your Answer |
|----------|-------------|
| How does a rolling update avoid downtime? | |
| What gate must a new pod pass before getting traffic? | |
| Liveness fail vs readiness fail — different actions? | |
| Same image as Compose (M34)? What changes between them? | |

---

## You'll know it worked when:

- [ ] You can explain reconciliation / desired state
- [ ] You can map each object to its role
- [ ] You can explain config/secret injection → Spring
- [ ] You can explain probe-driven self-healing and zero-downtime updates
