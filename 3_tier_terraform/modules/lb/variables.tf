variable "backend_name" {
  description = "The name of the backend"
  type = string
}

variable "backend_group" {
  description = "The name of the backend group"
  type = string
}

variable "url_map_name" {
  description = "The name of the url map"
  type = string
}

variable "http_proxy_name" {
  description = "The name of the http proxy"
  type = string
}

variable "http_forwarding_rule_name" {
  description = "The name of the http forwarding rule"
  type = string
}