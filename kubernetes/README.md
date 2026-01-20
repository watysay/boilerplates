# KUBERNETES


Documentation générique sur K8S:
- installation
- tutoriel basique

## Installation

J'installe K3s sur une seule machine vagrant pour tester :
```ruby
Vagrant.configure("2") do |config|

  config.vbguest.auto_update = false
  config.vbguest.no_install = true
  config.vm.synced_folder ".", "/vagrant"

  config.vm.define "ubuntu" do |sb|
    sb.vm.box = "ubuntu/jammy64"
    
    sb.vm.provider "virtualbox" do |v|
      v.cpus = 2
      v.memory = 2048
    end
    sb.vm.network "forwarded_port", guest: 8001,  host: 8001
    
    sb.vm.provision "shell" do |s|
      s.inline = "apt-get update && apt-get upgrade -yq"
    end
  end
end
```

Une fois connecté (```vagrant ssh ubuntu```), il suffit d'installer K3S (https://docs.k3s.io/quick-start) :

```curl -sfL https://get.k3s.io | sh - ```



## Découverte

Je pars ensuite sur la documentation officielle de Kubernetes pour les bases : https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-app/deploy-intro/

Pour voir l'ensemble de ce qui tourne en un clin d'oeil :
```sh
kubectl get nodes,pods,deployments,svc,ingressClasses,ingress -o wide
```

![Voir les informations nodes,pods,deployments](../.assets/k8s_get_all_infos.png)

On peut récupérer des informations sur le déroulement via les logs :
```kubectl logs "$POD_NAME" -f```

admin@mngmt:~/kube$ k get ingressClasses,ingress -o wide
ou en allant voir à l'intérieur éventuellement :
```kubectl exec -ti $POD_NAME -- bash```

![Visite à l'interieur du container du pod](../.assets/k8s_exec.png)

## Commandes utiles

> api-resources
Permet de détailler tous les objets Kubernetes

> apply (-f fichier.yml)
Permet d'appliquer le fichier en question, qui doit
définir des objets (Pods, Deployment, Service, etc)

> describe
Permet d'avoir les informations sur l'objet en question


## Helm


Utilisation Rapide

```sh
# show all repo
helm repo list
# show charts
helm search repo
# show default values for specific chart
helm show values <chart> |  grep -vE '^[[:space:]]*#|^$' > default-values-<chart>.yaml
## now change values as needed based on app documentation
# install app with custom values
helm install --values my-values.yaml <release name> <chart>
# if need be, upgrade release
helm upgrade --values my-values.yaml <release name> <chart>
```
