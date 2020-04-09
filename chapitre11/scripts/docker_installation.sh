#!/bin/bash

set -e

echo "Installing Docker..."

sudo su

yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce-18.06.0.ce-3.el7

systemctl start docker && systemctl enable docker

usermod -aG docker vagrant