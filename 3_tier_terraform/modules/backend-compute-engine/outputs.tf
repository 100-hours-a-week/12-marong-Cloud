output "instance_name" {
  value = google_compute_instance_template.backend-vm.name
}

output "instance_ip" {
  value = google_compute_instance_template.backend-vm.network_interface[0].access_config[0].nat_ip
}

output "instance_group_name" {
  value = google_compute_instance_group_manager.backend-group.name
}