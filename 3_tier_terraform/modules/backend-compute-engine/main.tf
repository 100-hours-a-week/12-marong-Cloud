resource "google_compute_instance" "backend-vm" {
  name = "${var.backend_name}-${var.name}"
  machine_type = var.machine_type
  zone = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size = var.disk_size
    }
  }

  network_interface {
    subnetwork = var.subnetwork
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_path)}"
    startup-script = file("${path.module}/startup-be.sh")
  }

  tags = var.tags

  service_account {
    email = var.service_account_email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance_group" "backend-group" {
  name = "${var.backend_name}-${var.name}"
  zone = var.zone
  instances = [
    google_compute_instance.backend-vm.self_link
  ]
  named_port {
    name = "http"
    port = 8080
  }
}