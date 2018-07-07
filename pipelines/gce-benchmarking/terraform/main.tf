variable "gce_ssh_user" {}
variable "gce_ssh_pub_key_file" {}
variable "gce_ssh_key_file" {}
variable "gce_image" {}
variable "gce_service_account" {}

variable "gce_region" {
  default = "us-east1-b"
}

variable "gce_machine_type" {
  default = "g1-small"
}

resource "random_id" "server" {
  byte_length = 8
}

provider "google" {
  credentials = "${file(var.gce_service_account)}"
  project     = "gce-baseliner"
  region      = "${var.gce_region}"
}

resource "google_compute_instance" "baseliner_vm" {
  count        = 1
  name         = "baseliner-${random_id.server.hex}"
  machine_type = "g1-small"
  zone         = "${var.gce_region}"

  boot_disk {
    initialize_params {
      image = "${var.gce_image}"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata {
    ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }

  connection {
    type        = "ssh"
    user        = "${var.gce_ssh_user}"
    private_key = "${file(var.gce_ssh_key_file)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common",
      "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable\" -y",
      "sudo apt-get update",
      "sudo apt-get -y install docker-ce",
      "sudo groupadd docker",
      "sudo usermod -aG docker ${var.gce_ssh_user}",
    ]
  }
}

output "external_ip"{
  value = "${google_compute_instance.baseliner_vm.network_interface.0.access_config.0.assigned_nat_ip} ansible_user=${var.gce_ssh_user}"
}
