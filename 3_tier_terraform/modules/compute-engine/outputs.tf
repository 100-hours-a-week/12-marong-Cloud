output "instance_name" {
  value = google_compute_instance.marong-vm.name
}

output "instance_ip" {
  value = google_compute_instance.marong-vm.network_interface[0].access_config[0].nat_ip
}