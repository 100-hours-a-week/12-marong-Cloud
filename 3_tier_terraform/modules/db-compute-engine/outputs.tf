# This file is intentionally left empty as there are no required outputs
output "db_ip" {
    value = google_compute_address.db-ip.address
}