# Walkthrough: Infrastructure & CI/CD Status

## 🚀 Active Services

| Service | URL | Status |
| :--- | :--- | :--- |
| **Jenkins** | [http://13.233.63.34:8080](http://13.233.63.34:8080) | **Live** (Bypass Mode) |
| **SonarQube** | [http://13.233.63.34:9000](http://13.233.63.34:9000) | **Live** (`admin`/`admin`) |

## 🛠️ Environment Configuration

### 1. The Jenkins Engine
We are using a **Custom Docker-based Jenkins** on a `t3.micro` EC2. 
- **Tooling**: Includes `aws-cli` and `docker-cli`.
- **Network**: Uses the `docker.sock` from the host to perform builds.

### 2. AWS Integration
- The EC2 instance uses an **IAM Instance Profile** (`jenkins-instance-profile`).
- No secret keys are stored in Jenkins. It uses `aws ecr get-login-password` for push authorization.

## 🔒 Security Lockdown (Manual Step)
Once your pipeline is green, you MUST re-enable security:
1. Set an admin password in Jenkins UI.
2. Run this in WSL:
```bash
wsl -d Ubuntu bash -c "ssh -o StrictHostKeyChecking=no -i ~/.ssh/jenkins_key ec2-user@13.233.63.34 'sudo docker exec jenkins sed -i \"s/<useSecurity>false/<useSecurity>true/\" /var/jenkins_home/config.xml && sudo docker restart jenkins'"
```
