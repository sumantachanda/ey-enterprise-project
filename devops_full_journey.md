# EY Enterprise Project: The Complete DevOps Journey
**Date:** April 2, 2026
**Engineer:** Antigravity (Pair Programming with User)

## 🏗️ Phase 1: Project Foundation & Containerization
- **Objective:** Create a production-ready FastAPI application with enterprise-grade containerization.
- **Key Actions:**
  - Developed `app/main.py` (FastAPI ETL Simulator).
  - Created a multi-stage `Dockerfile` to optimize image size and security.
  - Implemented `docker-compose.yml` for local orchestration.

## 🏁 Phase 2: Infrastructure as Code (Terraform)
- **Objective:** Provision a scalable AWS environment in `ap-south-1` (Mumbai).
- **Key Actions:**
  - Configured S3 Backend with DynamoDB state locking.
  - Built a modular VPC with public and private subnets.
  - Provisioned a `t3.micro` EC2 instance with an **IAM Instance Profile** (`AmazonEC2ContainerRegistryPowerUser`) to avoid managing static credentials.

## 🛡️ Phase 3: Configuration Management (Ansible)
- **Objective:** Automate the setup of Jenkins and SonarQube.
- **Key Actions:**
  - Created `ansible/setup.yml` to install Docker, Java, and Jenkins.
  - **Constraint Solved:** Injected the AWS CLI and Docker CLI directly into the Jenkins container to allow "Docker-outside-of-Docker" builds on a Free Tier instance.
  - Added a 4GB Swap file to ensure stability during builds.

## 🚀 Phase 4: CI/CD Pipeline & DevSecOps (In Progress)
- **Objective:** Automate security scanning and ECR deployment.
- **Critical Troubleshooting Items:**
  - **The "Bypass" Mode:** Temporarily disabled Jenkins security to expedite configuration.
  - **Docker Socket Permissions:** Identified that the Jenkins user required root-level access to `/var/run/docker.sock` to trigger host-level builds.
  - **Buildx Workaround:** Solved the `docker-compose build` dependency issue by performing manual Docker builds of the custom Jenkins image.

## 📜 Master Command History (Most Important)

### Jenkins Recovery & Permissions Fix:
```bash
wsl -d Ubuntu bash -c "ssh -o StrictHostKeyChecking=no -i ~/.ssh/jenkins_key ec2-user@13.233.63.34 'cd /home/ec2-user/tools/jenkins && sudo docker build -t custom-jenkins:latest . && cd /home/ec2-user/tools && sudo /usr/local/bin/docker-compose up -d && sudo chmod 666 /var/run/docker.sock && sudo docker ps'"
```

### Git Sourcing & Push (From WSL):
```bash
wsl -d Ubuntu bash -c "cd /mnt/c/Users/suman/Desktop/ey-enterprise-project && git add . && git commit -m 'feat: Enterprise CI/CD pipeline' && git push origin main"
```

## 🔒 Security Corner (Interview Topics)
1. **DooD vs DinD**: Why we mounted the socket instead of running a container inside a container.
2. **Stateless Pipelines**: Using Jenkins with IAM Roles instead of Access Keys.
3. **Quality Gates**: How SonarQube ensures only secure code reaches production.

---
*Note: This document serves as a full transcript of the engineering logic and implementation steps taken during the project development.*
