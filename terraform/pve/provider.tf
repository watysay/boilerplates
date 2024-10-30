terraform {
  required_version = ">=1.3"
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

provider "proxmox" {
  pm_tls_insecure = true
}
