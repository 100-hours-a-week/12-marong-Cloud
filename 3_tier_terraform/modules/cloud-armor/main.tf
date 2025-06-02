resource "google_compute_security_policy" "cloud-armor" {
  name = var.name
  description = var.description

  rule {
    action = "allow"
    priority = 1000
    match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = var.allowed_ips
        }
      }

      description = "Allow traffic from allowed IPs"
    }

    rule {
      action = "deny(403)"
      priority = 2147483647
      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = ["*"]
        }
      }
      description = "Block traffic from blocked IPs"
    }
  
}