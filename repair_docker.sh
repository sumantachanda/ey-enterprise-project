#!/bin/bash
ssh -o StrictHostKeyChecking=no -i ~/.ssh/jenkins_key ec2-user@13.233.63.34 << 'EOF'
sudo docker exec -u root jenkins bash -c "curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-24.0.5.tgz | tar -xz -C /usr/bin --strip-components=1 docker/docker"
sudo docker exec jenkins docker --version
EOF
