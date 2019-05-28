variable "PACKET_API_KEY" {}
provider "packet" {
  auth_token = "${var.PACKET_API_KEY}"
}
locals {
  project_id = "ead345e7-4525-4d09-bf49-c8b2b6e0f9cf"
}
resource "packet_device" "hibench" {
  hostname="hibench"
  project_id       = "${local.project_id}"
  operating_system = "ubuntu_16_04"
  plan = "t1.small.x86"
  billing_cycle    = "hourly"
  facilities = ["ewr1"]

  provisioner "local-exec" {
    command = "echo ${packet_device.hibench.access_public_ipv4} > ../ansible/hosts.ini"
  }

}
output "ip" {
  value = packet_device.hibench.access_public_ipv4
}