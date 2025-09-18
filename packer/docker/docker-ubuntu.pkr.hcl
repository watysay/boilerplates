packer {
  required_plugins {
    docker = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:jammy"
  commit = true
}

build {
  sources = [
    "source.docker.ubuntu"
  ]
  name = "learn-packer"

  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]
    inline = [
      "echo Adding file to Docker Container",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }

  provisioner "shell" {
    inline = [<<EOF
echo \"Adding this line \
to the file\" >> example.txt
EOF
    ]
  }

  post-processor "docker-tag" {
    repository = "ubuntu-packer"
    tag        = ["0.2", "latest"]
  }




}
