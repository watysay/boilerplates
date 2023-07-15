#!/bin/bash

VERSION="4.14.1"
curl -fOL https://github.com/coder/code-server/releases/download/v$VERSION/code-server_${VERSION}_amd64.deb
sudo dpkg -i code-server_${VERSION}_amd64.deb
sudo systemctl enable --now code-server@$USER
sed -i s/127.0.0.1:8080/0.0.0.0:8080/ .config/code-server/config.yaml
sudo systemctl restart code-server@$USER
echo " Now visit http://<ip> :8080. Your password is in ~/.config/code-server/config.yaml"
#https://github.com/coder/code-server/releases/download/v4.14.1/code-server_4.14.1_amd64.deb
