# 🐋 docker

Docker tools for random tasks

- docker ansible         : run ansible from container
- docker gitlab ci local : run gitlab ci on local machine


## Aliases and functions


By default alias ending with image name will run CMD.
Aliases/functions with another ending will replace this,
executing the last command (i.e. bash, ansible-playbook, etc).

To create alias file to source run:
```perl -ne "print if /#MARK/../#ENDMARK/" README.md > docker_aliases ; . docker_aliases```

For docker-ansible:
```
#MARK
alias myansible='docker run -it --rm --name docker-ansible -v $PWD:/ansible -v "/var/run/docker.sock:/var/run/docker.sock" docker-ansible'
ansible-config () {    myansible ansible-config ; }
ansible-console () {   myansible ansible-console ; }
ansible-galaxy () {    myansible ansible-galaxy ; }
ansible-inventory () { myansible ansible-inventory ; }
ansible-lint () {      myansible ansible-lint ; }
ansible-playbook () {  myansible ansible-playbook ; }
ansible-pull () {      myansible ansible-pull ; }
ansible-test () {      myansible ansible-test ; }
ansible-vault () {     myansible ansible-vault ; }
#ENDMARK
```

For docker gitlab ci local:
```
#MARK
alias glab-ci-local='docker run -it --rm --name gitlab-ci-local -v "$PWD:/home/node/gitlab-ci/" -v "/var/run/docker.sock:/var/run/docker.sock" docker-gitlab-ci-local:latest'
#ENDMARK
```
