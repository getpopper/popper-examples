variable "PACKET_API_KEY" {}
variable "WORKERS_COUNT" { default = 1 }

provider "packet" {
  auth_token = "${var.PACKET_API_KEY}"
}

locals {
  project_id = "ead345e7-4525-4d09-bf49-c8b2b6e0f9cf"
}

resource "packet_device" "spark_master" {
  hostname="spark.master"
  project_id       = "${local.project_id}"
  operating_system = "ubuntu_16_04"
  plan = "t1.small.x86"
  billing_cycle    = "hourly"
  facilities = ["ewr1"]
  provisioner "local-exec" {
    command = "cat <<EOF > ../ansible/hosts.ini\n[master]\n${self.access_public_ipv4} ansible_user=root ansible_become=True\n[workers]\nEOF"

  }

}
resource "packet_device" "spark_worker" {
  count = "${var.WORKERS_COUNT}"
  hostname="spark.worker.${count.index}"
  project_id       = "${local.project_id}"
  operating_system = "ubuntu_16_04"
  plan = "t1.small.x86"
  billing_cycle    = "hourly"
  facilities = ["ewr1"]
  provisioner "local-exec" {
    command = "echo '${self.access_public_ipv4} ansible_user=root ansible_become=True' >> ../ansible/hosts.ini"
  }
  depends_on = [
    packet_device.spark_master,
  ]
}
output "master_ip" {
  value = packet_device.spark_master.access_public_ipv4
}
output "worker_ips" {
  value = "${packet_device.spark_worker.*.access_public_ipv4}"
}
