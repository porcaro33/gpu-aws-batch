#!/bin/bash
# setup docker-ce, awscli and packer on CentOS7
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-from-a-package
# http://docs.aws.amazon.com/cli/latest/userguide/installing.html
# https://www.packer.io/intro/getting-started/install.html#precompiled-binaries

# install basic tools
sudo yum update -y
sudo yum install -y kernel-devel-$(uname -r)
sudo yum groupinstall -y "Development tools"
sudo yum install -y epel-release
sudo yum install -y wget tree lsof net-tools traceroute htop git tmux dstat telnet vim bzip2 zip unzip rsync zsh ksh python-pip

# install awscli
sudo pip install --upgrade pip
sudo pip install awscli

# install docker-ce
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce
sudo systemctl start docker

# install packer
sudo yum install packer -y
