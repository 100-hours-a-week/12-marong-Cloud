resource "google_compute_instance" "marong-vm" {
  name = var.name
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
    access_config {}
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_path)}"
  }

  tags = var.tags

  service_account {
    email = var.service_account_email
    scopes = ["cloud-platform"]
  }
}