packer {
  required_plugins {
    name = {
      version = "= 1.2.1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "pvenode" {
  type    = string
  default = "pveh2"
}

/*
proxmox_url, token et username sont récupérés via les variables d'env
PROXMOX_URL, PROXMOX_TOKEN et PROXMOX_USERNAME
*/
source "proxmox-iso" "ubuntu" {

  insecure_skip_tls_verify = true
  vm_id                    = 9999
  memory                   = 1024
  cores                    = 1
  disks {
    disk_size    = "5G"
    storage_pool = "local-lvm"
    type         = "scsi"
  }
  iso {
    #iso_file = "local:iso/Fedora-Server-dvd-x86_64-29-1.2.iso"
    iso_url = "https://releases.ubuntu.com/noble/ubuntu-24.04.1-live-server-amd64.iso"
    iso_checksum = "file:https://releases.ubuntu.com/noble/SHA256SUMS"
  }
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  node                 = "${var.pvenode}"
  #username             = "${var.username}"
  #password             = "${var.password}"
  #proxmox_url          = "https://my-proxmox.my-domain:8006/api2/json"
  ssh_username         = "root"
  ssh_password         = "packer"
  ssh_timeout          = "15m"
  template_description = "Ubuntu 24.04 LTS, generated on ${timestamp()}"
  template_name        = "ubuntu24"
}

build {
  sources = ["source.proxmox-iso.ubuntu"]
}
