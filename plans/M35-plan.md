# M35 Plan — Kubernetes Essentials

**Track:** Containerization & Deployment (key: deployment, color: #34d399)
**Level:** Advanced
**Status:** ✅ BUILT

## Concepts
1. Kubernetes: Cluster Orchestration — visual `m35-cluster` (desired state reconciliation)
2. Pods, Deployments & Services — visual `m35-pod-deploy-svc`
3. Config & Secrets: ConfigMap, Secret — visual `m35-config-secret`
4. Probes & Self-Healing — visual `m35-probes-healing` (uses M32 probes)

## Coming From Java
Fixed servers, manual scaling/failover, downtime on updates. K8s: declarative, self-healing, rolling.

## Code
- Deployment (3 replicas) + Service YAML
- ConfigMap + Secret + envFrom
- liveness/readiness probes in Deployment

## SVG
- cluster 640×260, pod-deploy-svc 640×270, config-secret 640×250, probes-healing 640×260
