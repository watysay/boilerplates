#!/bin/bash
#
# install git, créé paire clé rsa et prep la config git
#
sudo apt update -qq
sudo apt install git -qq

git config --global user.name $USER
git config --global user.email $USER@mail.lab

if ! [[ -f ~/.ssh/id_rsa ]]; then
  echo "Generating ssh keys ...."
  ssh-keygen
fi

echo "Now copy/paste this in github/gitlab account ssh keys"
cat ~/.ssh/id_rsa.pub

