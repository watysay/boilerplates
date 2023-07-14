resource "proxmox_vm_qemu" "debian-vm" {
    
    target_node = "pvehv1"

    count = 2
    vmid = "${1000 + count.index}"
    name = "debian-test-${count.index}"
    clone = "debian-12-ci-template"
    
    # gestion materiel
    cores = 1
    memory = 512
    scsihw = "virtio-scsi-pci"
    #ipconfig0 = "dhcp" # is not working with dhcp ...
    ipconfig0 = "ip=192.168.1.${100 + count.index}/16,gw=192.168.1.1"
    nameserver = "192.168.1.1"

    # on met en route qemu agent
    agent = 1

    # on ajoute la config cloud-init
    os_type = "cloud-init"
    ciuser = "admin"
    sshkeys = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNbQeAQH6KRvWXTZ6a43AvviBlD2XK4k/clt8cFIjgRuSKEZfLadcse5vQ7q6VxlbOLdD4uXMS5MNLmMUSaFoWPngT0yZq1a1j/ooA434MoMB3ytJxsct8EM4w3AO4Zn1dg/0CgTQdADNwQ7pDxX1SPw3thm72lhz8+/ES7O8Xp6Vguj7GW11NN4+oRk9R/Kl4DwOUcqM2TeBStBMwHtC1oINq3WYyNm1M+pchCBdszElYLZS9Ma7sF42PRP1+VYCSYwEK2UGdRod1ggsmnCYpuVN7snwpKopsleM28Ei0IqtX1aDnuLStWValKxMk9WGkuE4vnyyjL+vOcexXhRK0bwBGDpaTNAJOALIoV4XAIG15bNpHcnfCT631l8kSlaGBEEKYlas3occS15EZQ/C9Zpb0S9NsV2NpGnLcbQ8x4tTDIu2wSTPIhVhscTQIv+DIcpDVNuQM4McYxuw5vCj2PTXMyowTINbTVg9D0jYL5sQno0QR6CBmhQis+pDIGgc=
    EOF
}