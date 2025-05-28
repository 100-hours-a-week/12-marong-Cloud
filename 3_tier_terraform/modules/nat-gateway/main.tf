resource "google_compute_route" "nat-router" {
  name = var.name
  network = var.network
  dest_range = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_router" "router" {
  name    = "${var.name}-router"
  region  = var.region
  network = var.network
}

resource "google_compute_router_nat" "nat" {
  name                               = var.name
  router                            = google_compute_router.router.name
  region                            = var.region
  nat_ip_allocate_option            = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  enable_endpoint_independent_mapping = true

  dynamic "subnetwork" {
    for_each = var.private_subnets
    content {
      name                    = subnetwork.value
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }
}