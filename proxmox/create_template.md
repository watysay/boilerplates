# PVE template creation

Inspirer du travail de https://github.com/techno-tim
et de la documentation proxmox https://pve.proxmox.com/wiki/Cloud-Init_Support

```sh

# à lancer sur un noeud pve
# prerequis pve : libguestfs-tools

# declare variables as integers
declare -i idmin idtmp id

# retrieve useful id : templates are created with id >= 9000 as convention
idmin=9000
idtmp="$(qm list | awk -v idmin=$idmin '$1 >= idmin { print $1 }' | tail -n1)"
# on recupere 0 si on a des lettres, soit 'VMID' par exemple
if [[ "$idtmp" == "0" ]]; then
  id=$idmin
else
  # increment de numero de template
  id=$(( idtmp + 1 ))
fi

# define here url of qcow2 file, name of downloaded image and name of template
# examples with Rocky9 and Debian12
url="https://dl.rockylinux.org/pub/rocky/9/images/x86_64/Rocky-9-GenericCloud-Base.latest.x86_64.qcow2"
img="./Rocky-9-GenericCloud-Base.latest.x86_64.qcow2"
name="rocky-9-ci-template-${id}"

url="https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
img="./debian-12-generic-amd64.qcow2"
name="debian-12-ci-template-${id}"

# download qcow2 image
wget "$url" "$img"

# add qemu-guest-agent to the image
virt-customize -a "$img" --install qemu-guest-agent

# truncate machine-id files; touch first to ensure present
virt-customize -a "$img" \
  --touch /etc/machine-id \
  --touch /var/lib/dbus/machine-id \
  --truncate /etc/machine-id \
  --truncate /var/lib/dbus/machine-id

# create vm
qm create "$id" --name "$name" --memory 1024 --cores 1 --net0 virtio,bridge=vmbr0
# disk creation from img 
qm importdisk "$id" "$img" local-lvm
# disk provisioning from img
qm set "$id" --scsihw virtio-scsi-pci --scsi0 "local-lvm:vm-$id-disk-0"
# add 10G to hdd size
qm resize "$id" scsi0 +10G
qm set "$id" --ide2 local-lvm:cloudinit
qm set "$id" --boot order=scsi0
qm set "$id" --serial0 socket --vga serial0
qm set "$id" --agent enabled=1

# here change manually cloud-init config of vm-template

# template the machine
qm template "$id"

```
