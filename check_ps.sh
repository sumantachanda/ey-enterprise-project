#!/bin/bash
ssh -o StrictHostKeyChecking=no -i ~/.ssh/jenkins_key ec2-user@13.233.63.34 << 'EOF'
sudo docker ps -a | grep jenkins
EOF
