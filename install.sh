#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Update the package index
sudo apt-get update

# Install dependencies
sudo apt-get install ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings

# Add Docker GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again
sudo apt update

# Install Docker
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Verify installation
sudo docker run hello-world
