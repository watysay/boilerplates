#!/bin/bash

# installation de ce qui est nécessaire pour le test de molecule
# à jouer dans une VM !

set -e

# need docker !!
# fails if not installed
docker --version > /dev/null

# apt
sudo apt-get update
sudo apt-get install -y git python3 python3-pip python3-virtualenv

# pip 
cd
virtualenv venv
. venv/bin/activate
pip install ansible==8.0 docker molecule molecule-plugins[docker] yamllint ansible-lint

python --version
ansible --version
molecule --version


git clone https://github.com/geerlingguy/ansible-for-devops.git
cd ansible-for-devops/molecule/
molecule test


