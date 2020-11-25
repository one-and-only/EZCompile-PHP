#!/bin/bash

echo installing Docker
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
echo installed Docker
echo masking firewalld
sudo systemctl mask firewalld
echo stopping firewalld service
sudo systemctl stop firewalld
echo installing iptables
sudo yum -y install iptables-services
echo enabling iptables systemctl service
sudo systemctl enable iptables
echo enabling ip6tables systemctl service
sudo systemctl enable ip6tables
echo starting iptables
sudo systemctl start iptables
echo starting ip6tables
sudo systemctl start ip6tables
