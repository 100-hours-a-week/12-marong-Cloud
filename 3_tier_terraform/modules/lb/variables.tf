variable "backend_name" {
  description = "The name of the backend"
  type = string
}

variable "backend_group_01" {
  description = "The name of the backend group 01"
  type = string
}

variable "backend_group_02" {
  description = "The name of the backend group 02"
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

variable "project_id" {
  description = "The project ID to deploy resources into"
  type = string
}

variable "zone" {
  description = "The zone to deploy resources into"
  type = string
} 

variable "security_policy" {
  description = "The name of the security policy"
  type = string
}

variable "lb_name" {
  description = "The name of the load balancer"
  type = string
}