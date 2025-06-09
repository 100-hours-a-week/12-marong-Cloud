output "instance_name" {
  value = google_compute_instance_template.backend-vm.name
}

output "instance_group_name" {
  value = google_compute_instance_group_manager.backend-group.name
}