output "instance_group_self_link" {
  value = google_compute_instance_group.backend-group.self_link
}

output "instance_group_name" {
  value = google_compute_instance_group.backend-group.name
}