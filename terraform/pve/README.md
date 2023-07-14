Terraform : Proxmox PVE

Comment créer des VMs à partir de template

https://registry.terraform.io/providers/Telmate/proxmox/latest/docs

Gestion des credentials :
Datacenter > Permissions 
Créer un group IAC
un user iac
lui faire un API Token (connu une seule fois !)
lui mettre des droits admin

Créer un fichier .pm_config
mettre dedans :
```
export PM_API_URL="https://{{ promox_host }}:8006/api2/json"
export PM_API_TOKEN_ID="terraform-prov@pve!mytoken"
export PM_API_TOKEN_SECRET="........"
```
sourcer ce fichier .pm_config



https://github.com/Telmate/terraform-provider-proxmox/blob/master/docs/resources/vm_qemu.md#argument-reference
