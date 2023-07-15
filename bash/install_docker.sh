#!/bin/bash

# installation de ce qui est nécessaire pour le test de molecule
# à jouer dans une VM !

set -e

# apt
sudo apt-get update

# docker
curl -fsSL https://get.docker.com -o get-docker.sh ;
sudo sh get-docker.sh

sudo usermod -a -G docker $USER
newgrp docker

