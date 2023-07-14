#!/bin/bash

# installation de ce qui est nécessaire pour le test de molecule
# à jouer dans une VM !

set -e

# apt
sudo apt-get update
sudo apt-get install -y git python3 python3-pip python3-virtualenv

# docker
curl -fsSL https://get.docker.com -o get-docker.sh ;
sudo sh get-docker.sh

sudo usermod -a -G docker $USER
newgrp docker

# pip 
cd
virtualenv venv
. venv/bin/activate
pip install ansible==6.0 docker molecule[docker] yamllint ansible-lint

python --version
ansible --version
molecule --version


git clone https://github.com/geerlingguy/ansible-for-devops.git
cd ansible-for-devops/molecule/
molecule test



