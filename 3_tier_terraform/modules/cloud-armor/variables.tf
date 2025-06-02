variable "name" {
  description = "The name of the security policy"
  type = string
}

variable "description" {
  description = "The description of the security policy"
  type = string
}

variable "allowed_ips" {
  description = "The allowed IPs"
  type = list(string)
}