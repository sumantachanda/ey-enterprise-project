# Enterprise-Grade DevOps & Cloud Platform Project Plan

Based on the **EY Cloud Platform Engineer** Job Description and your resume, this project is designed to give you end-to-end, production-grade experience. It moves beyond isolated tutorials into a unified, enterprise architecture.

By completing this, you will confidently check off 95% of the highly technical requirements in that JD, specifically: Terraform Modules, EKS (Kubernetes), Jenkins CI, Helm, ArgoCD, DevSecOps, and Observability (Grafana/CloudWatch).

## The Scenario
You are the Lead Cloud Engineer for a new FinTech data processing application. You need to build the infrastructure (including a self-hosted Jenkins CI server), deploy the application securely to an EKS cluster, establish a GitOps workflow, and set up advanced observability.

---

## Phase 1: The Codebase & Local Development (App & Docker)
*JD Alignment: Docker, Python scripting, SDLC*

1. **The Application:** Create a Python API (Flask or FastAPI) that exposes a `/process_data` endpoint (simulating ETL). It takes JSON, processes it, and spits out a result with logs.
2. **Containerization:** Write a multi-stage `Dockerfile` optimized for production (using a non-root user, slim images).
3. **Local Testing:** Bring it up locally with `docker-compose` to ensure the app works.

## Phase 2: Infrastructure as Code (Terraform & AWS)
*JD Alignment: AWS provisioning, Terraform modules, EKS, Well Architected Framework*

1. **Bootstrap State:** Create an S3 Backend and DynamoDB table for state locking.
2. **Modular Architecture:** Build the infrastructure using standard **Terraform Modules**.
3. **The Network:** Build a secure VPC with Public Subnets and Private Subnets.
4. **Jenkins Server Provisioning:** Provision a dedicated EC2 instance in the public subnet to act as our CI Server.
5. **The Cluster:** Provision an **AWS EKS** (Elastic Kubernetes Service) cluster inside the private subnets.

## Phase 3: Configuration Management (Ansible & Jenkins)
*JD Alignment: Ansible Config Management, Jenkins Setup*

1. **Ansible Playbook:** Write an Ansible playbook to configure the EC2 instance we just provisioned.
2. **Jenkins Installation:** The playbook will install Docker, Java, and **Jenkins**, and secure the server.
3. **Jenkins Setup:** We will log into Jenkins and configure the raw environment.

## Phase 4: Continuous Integration & DevSecOps (Jenkins)
*JD Alignment: Jenkins CI/CD Pipeline, DevSecOps, SAST*

1. **The CI Pipeline:** Create a `Jenkinsfile` (Groovy script) that triggers on a git push.
2. **Security Scans:** Integrate SAST scanning inside Jenkins to scan the Python code and the Dockerfile for vulnerabilities before building.
3. **Build & Push:** If security passes, Jenkins will build the Docker image and push it to AWS ECR (Elastic Container Registry) or DockerHub.

## Phase 5: GitOps & Kubernetes Deployment (Helm & ArgoCD)
*JD Alignment: ArgoCD, Helm Charts, Kubernetes Deployments*

1. **Helm Chart:** Package your Python app into a reusable **Helm Chart** with a `values.yaml` file to separate configs for `dev` and `prod`.
2. **GitOps Setup:** Install **ArgoCD** into your AWS EKS cluster.
3. **The CD Pipeline:** Configure ArgoCD to monitor a dedicated Config Repository on GitHub. When Jenkins pushes a new image tag to GitHub, ArgoCD automatically syncs and deploys the new image to EKS.

## Phase 6: Observability & Resilience (CloudWatch & Grafana)
*JD Alignment: CloudWatch, Grafana, SRE Practices, Observability Framework*

1. **Metrics Collection:** Configure your EKS cluster to send node and pod metrics to **AWS CloudWatch**.
2. **Log Aggregation:** Install Fluent-bit to stream your Python application text logs into AWS CloudWatch Logs.
3. **The Dashboard:** Spin up a **Grafana** instance connected to CloudWatch.
4. **SRE Visualization:** Build an executive Grafana dashboard tracking EKS CPU utilization and Python error rates.

---

## User Review Required

> [!IMPORTANT]
> **I have added the Jenkins setup via Ansible to Phase 3 and Phase 4!** 
> 
> My teaching style will remain EXACTLY the same: Step-by-step, waiting for your confirmation, no dumping. However, the **Interview Prep Corner** questions will now be much deeper and more technical to match an Enterprise Engineering role.
> 
> Are you ready to begin Phase 1? If yes, go ahead and create a brand new, empty folder on your Desktop (e.g. `ey-enterprise-project`) and reply with **"Ready!"**
TEACHING STYLE:
For each step:

Explain in simple terms (like I am beginner)
Tell me exactly what to do
Give me commands/code
Ask me to run it
Then ask me questions to check understanding

INTERVIEW PREP MODE:
After each section (Ansible, Monitoring, Git, ETL), give me:

2–3 interview questions
Simple, safe answers I can say

CONSTRAINTS:

Do NOT assume I am an expert
Do NOT go deep into enterprise-scale systems
Keep everything beginner to intermediate
Focus on clarity and confidence, not complexity

IMPORTANT INTERVIEW ALIGNMENT:
Make sure I can safely explain:

“Used Ansible for basic configuration automation”
“Worked with monitoring tools like Grafana and CloudWatch”
“Followed Git workflows with branching and code reviews”
“Worked on basic ETL/data processing pipelines for dashboards”

START WITH:
Step 1 — What is
