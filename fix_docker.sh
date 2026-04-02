#!/bin/bash
ssh -o StrictHostKeyChecking=no -i ~/.ssh/jenkins_key ec2-user@13.233.63.34 << 'EOF'
sudo chmod 666 /var/run/docker.sock
ls -l /var/run/docker.sock
sudo docker exec -u root jenkins chmod 666 /var/run/docker.sock
sudo docker exec jenkins ls -l /var/run/docker.sock
EOF
