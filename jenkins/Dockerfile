# Optimized "Lightweight" Jenkins for Free Tier Instances
FROM jenkins/jenkins:lts

USER root

# Install standard AWS CLI and Docker tools from Debian repos (Fast & Stable)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    awscli \
    curl \
    unzip && \
    # Install Docker CLI the fast way
    curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-24.0.5.tgz | tar -xz -C /usr/bin --strip-components=1 docker/docker && \
    # Cleanup to save every megabyte of disk space
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER jenkins
