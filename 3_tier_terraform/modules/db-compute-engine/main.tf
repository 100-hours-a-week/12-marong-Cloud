resource "google_compute_instance" "db-vm" {
  name = var.db_name
  machine_type = var.machine_type
  zone = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = var.image
      size = var.disk_size
    }
  }

  network_interface {
    subnetwork = var.subnetwork
    network_ip = google_compute_address.db-ip.address
    access_config { }
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_path)}"
    startup-script = file("${path.module}/startup-db.sh")
  }

  tags = var.tags

  service_account {
    email = var.service_account_email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_address" "db-ip" {
  name = var.db_name
  subnetwork = var.subnetwork
  region = var.region
  address_type = "INTERNAL"
}