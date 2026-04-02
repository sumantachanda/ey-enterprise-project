# Enterprise DevOps & Cloud Engineering: Master Plan

This 6-phase project is designed to give you end-to-end, production-grade experience for the **EY Cloud Platform Engineer** role.

## 🏁 The 6-Phase Journey

### ✅ Phase 1: The Codebase & Local Development
- Python API (FastAPI) for ETL simulation.
- Multi-stage production Dockerfile.
- Local testing with `docker-compose`.

### ✅ Phase 2: Infrastructure as Code (Terraform & AWS)
- S3 Backend & DynamoDB state locking.
- Modular VPC (Public/Private subnets).
- Dedicated EC2 for Jenkins & EKS Cluster provisioning.

### ✅ Phase 3: Configuration Management (Ansible)
- Automated tool installation (Docker, Java, Jenkins).
- AWS CLI & Docker CLI injection into the Jenkins container.

### 🔄 Phase 4: CI/CD Pipeline & DevSecOps (CURRENT)
- **Jenkinsfile**: Automated build/test/scan/push.
- **SonarQube**: SAST security scanning.
- **AWS ECR**: Pushing production images to a private registry.

### ⬜ Phase 5: GitOps & K8s (ArgoCD & Helm)
- Package app into **Helm Charts**.
- Install **ArgoCD** on EKS.
- Implement **GitOps** (Automatic sync from Git to K8s).

### ⬜ Phase 6: Observability (CloudWatch & Grafana)
- Metrics & Logs collection from EKS pods.
- Executive SRE Dashboard in Grafana.

---

## 🔒 Security Corner (Interview Topics)
- **IAM Instance Profiles**: Why we don't use Access Keys in code.
- **Docker Socket Security**: The risks of mounting `/var/run/docker.sock`.
- **Stateless CI**: Creating ephemeral build environments.
