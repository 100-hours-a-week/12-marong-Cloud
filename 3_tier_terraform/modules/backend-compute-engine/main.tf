resource "google_compute_instance_template" "backend-vm" {
  name = "${var.backend_name}"
  machine_type = var.machine_type
  region = var.region

  disk {
    source_image = var.image
    auto_delete = true
    boot = true
    disk_size_gb = var.disk_size
  }

  network_interface {
    subnetwork = var.subnetwork
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_path)}"
    # startup-script = templatefile("${path.module}/startup-be.sh", {
    #   db_ip = var.db_ip
    # })
  }

  tags = var.tags

  service_account {
    email = var.service_account_email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance_group_manager" "backend-group" {
  name = "${var.backend_name}"
  base_instance_name = "backend"
  version {
    instance_template = google_compute_instance_template.backend-vm.self_link
  }
  named_port {
    name = "http"
    port = 8080
  }

  update_policy {
    type = "PROACTIVE"
    minimal_action = "REPLACE"
    replacement_method = "RECREATE"
    max_unavailable_fixed = 1
  }

  target_size = var.target_size
}