resource "google_compute_security_policy" "cloud-armor" {
  name        = var.name
  description = var.description

  # Rate limit rule
  rule {
    priority    = 1000
    action      = "rate_based_ban"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["0.0.0.0/0"]
      }
    }

    rate_limit_options {
      rate_limit_threshold {
        count        = 1000
        interval_sec = 60
      }

      enforce_on_key = "IP"
      conform_action = "allow"
      exceed_action  = "deny(403)"
      ban_duration_sec = 600 # 10분 동안 밴
    }

    description = "Rate limit 1000 requests per minute"
  }

  # Default allow rule
  rule {
    priority    = 2000
    action      = "allow"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["0.0.0.0/0"]
      }
    }
    description = "Allow all traffic"
  }

  # Default rule (required by Cloud Armor)
  rule {
    priority    = 2147483647
    action      = "allow"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default rule, higher priority overrides it"
  }
}