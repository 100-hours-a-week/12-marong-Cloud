resource "google_compute_health_check" "health-check" {

  name = var.backend_name
  check_interval_sec = 10
  timeout_sec = 5
  healthy_threshold = 2
  unhealthy_threshold = 2

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "backend-service" {
  name = var.backend_name
  protocol = "HTTP"
  port_name = "http"
  timeout_sec = 10
  health_checks = [google_compute_health_check.health-check.self_link]
  load_balancing_scheme = "EXTERNAL"
  security_policy = var.security_policy

  backend {
    group = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/zones/${var.zone}/instanceGroups/${var.backend_group}"
  }
}

resource "google_compute_url_map" "url-map" {
  name = var.url_map_name
  default_service = google_compute_backend_service.backend-service.self_link
}

resource "google_compute_target_http_proxy" "http-proxy" {
  name = var.http_proxy_name
  url_map = google_compute_url_map.url-map.self_link
}

resource "google_compute_global_forwarding_rule" "http-forwarding-rule" {
  name = var.http_forwarding_rule_name
  target = google_compute_target_http_proxy.http-proxy.self_link
  port_range = "80"
  load_balancing_scheme = "EXTERNAL"
  ip_protocol = "TCP"
}