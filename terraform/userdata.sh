#!/bin/bash
apt-get update -y
apt-get upgrade -y
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
apt-get install docker-compose-plugin -y
systemctl enable docker
systemctl start docker
mkdir -p /app
cd /app