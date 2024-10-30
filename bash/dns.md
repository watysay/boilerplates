# installation et config dnsmasq


sudo apt install dnsmasq
nous donne l'erreur
dnsmasq[997]: failed to create listening socket for port 53: Address already in use

=> surement systemd-resolved

je fais donc
```
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved
```
puis remove / install de dnsmasq

On créé les fichiers suivants :
```
=== /etc/dnsmasq.conf ===
#### DNS ####
domain-needed
bogus-priv
# Ficher des forwarders
resolv-file=/etc/dnsmasq-dns.conf
strict-order
# Configuration domain
local=/home.lab/
domain=home.lab
expand-hosts
# Fichier des enregistrements A et AAAA
# ces fichiers seront lu en plus de /etc/hosts
addn-hosts=/etc/dnsmasq-hosts.conf
addn-hosts=/etc/dnsmasq-others.conf
# LOG DNS
log-queries
```
```
=== /etc/dnsmasq-dns.conf ===
nameserver 192.168.1.1
```
```
=== /etc/dnsmasq-hosts.conf ===
# LAN
192.168.1.x debian-test-1
192.168.1.y gitlab gitlab.lab
192.168.1.z pvehv1
```
Depuis une autre machine on tente des requetes nslookup :

```
admin@debian-test-1:~$ nslookup google.com
Server:		192.168.1.1
Address:	192.168.1.1#53

Non-authoritative answer:
Name:	google.com
Address: 142.250.179.110
Name:	google.com
Address: 2a00:1450:4007:818::200e

admin@debian-test-1:~$ nslookup google.com 192.168.1.100
Server:		192.168.1.100
Address:	192.168.1.100#53

Non-authoritative answer:
Name:	google.com
Address: 142.250.179.110
Name:	google.com
Address: 2a00:1450:4007:818::200e
```
=> OK pour la résolution globale

```
admin@debian-test-1:~$ nslookup gitlab
Server:		192.168.1.1
Address:	192.168.1.1#53

Non-authoritative answer:
*** Can't find gitlab: No answer

admin@debian-test-1:~$ nslookup gitlab 192.168.1.100
Server:		192.168.1.100
Address:	192.168.1.100#53

Name:	gitlab
Address: 192.168.1.x
```

=> OK pour la résolution locale

admin@debian-test-1:~$ nslookup gitlab.home.lab 192.168.1.100
Server:		192.168.1.100
Address:	192.168.1.100#53

Name:	gitlab.home.lab
Address: 192.168.1.x

=> on peut garder son nom de domaine également

Pour changer les nameserver d'une machine disposant de systemd-resolved :
```sh
sudo resolvectl dns eth0 192.168.1.200 192.168.1.1
sudo systemctl restart systemd-resolved.service
```
(on entre les ns par ordre de réponse voulue)
=> est-ce que c'est pérenne ou ça revient au default après un reboot ?

On peut mettre plusieurs fois la même IP avec des noms différents (sur des lignes différentes). Ca évite de passer par des cname dont la gestion est pas terrible avec dnsmasq

Sur les clients du DNS :
Pour Debian se référer à https://wiki.debian.org/resolv.conf
Une méthode qui résiste au reboot :
  - via sudo, unlink /etc/resolv.conf
  - utiliser l'éditeur pour entrer les lignes
    ```sh
    nameserver <adresse IP du srv DNS>
    search local
    ```
  - sauvegarder

Tester via /etc/systemd/resolved.conf si ça fonctionne :
- sudo rm /etc/resolv.conf
- changer #DNS= de /etc/systemd/resolved.conf par DNS=<ip dns>
- sudo reboot