#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y || exit
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add || exit
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" || exit
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y || exit
echo adding user to docker group
sudo usermod -aG docker $USER
echo applying changes
newgrp docker
