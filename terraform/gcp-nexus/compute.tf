variable "gcp_user" { default = "terraform" }
variable "gcp_key"  { default = "./ssh_key_private.pub" }
variable "public_ip" { default = "google_compute_instance.ubuntu-xenial.self_link" }

resource "google_compute_instance" "ubuntu-xenial" {
   name = "ubuntu-xenial"
   machine_type = "f1-micro"
   count = "1"
   zone = "us-west1-a"
   boot_disk {
      initialize_params {
      image = "ubuntu-1604-lts"
   }
   }
   provisioner "file" {
    source      = "playbook.yml"
    destination = "playbook.yml"
  }
   provisioner "local-exec" {
    command = "ansible-playbook -u ${var.gcp_user} -i ${var.public_ip}, --private-key ${file(var.gcp_key)} playbook.yml"
}

network_interface {
   network = "default"
   access_config {}
}
service_account {
   scopes = ["userinfo-email", "compute-ro", "storage-ro"]
   }
}
output "sample" {
  value = "${google_compute_instance.ubuntu-xenial.self_link}"
}
