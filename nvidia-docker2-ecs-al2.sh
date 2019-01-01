#!/bin/bash

set -ex
sudo yum update -y

# install basic tools
sudo yum install -y gcc-c++ gcc-gfortran vim wget pciutils

# install nvidia driver
sudo yum install -y kernel-devel-$(uname -r)
wget http://us.download.nvidia.com/tesla/410.79/NVIDIA-Linux-x86_64-410.79.run
chmod +x ./NVIDIA-Linux-x86_64-410.79.run
sudo ./NVIDIA-Linux-x86_64-410.79.run -s -z

# Install ecs-init, start docker, and install nvidia-docker 2
sudo yum install -y ecs-init
sudo service docker start
DOCKER_VERSION=$(docker -v | awk '{ print $3 }' | cut -f1 -d"-")
DISTRIBUTION=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$DISTRIBUTION/nvidia-docker.repo | sudo tee /etc/yum.repos.d/nvidia-docker.repo
PACKAGES=$(sudo yum search -y --showduplicates nvidia-docker2 nvidia-container-runtime | grep $DOCKER_VERSION | awk '{ print $1 }')
sudo yum install -y $PACKAGES
sudo pkill -SIGHUP dockerd

# Run test container to verify installation
# sudo docker run --privileged --runtime=nvidia --rm nvidia/cuda nvidia-smi

# Update Docker daemon.json to user nvidia-container-runtime by default
sudo tee /etc/docker/daemon.json <<EOF
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    },
    "default-runtime": "nvidia"
}
EOF

# restart docker service
sudo service docker restart
sudo docker ps
sudo docker images
#sudo docker rm $(sudo docker ps -aq)
#sudo docker rmi $(sudo docker images -q)
