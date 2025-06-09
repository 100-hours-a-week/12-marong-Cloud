variable "ai_name" {
  type = string
  description = "The name of the AI compute instance"
}

variable "machine_type" {
  type = string
  description = "The machine type of the AI compute instance"
}

variable "image" {
  type = string
  description = "The image of the AI compute instance"
}

variable "disk_size" {
  type = number
  description = "The disk size of the AI compute instance"
}

variable "subnetwork" {
  type = string
  description = "The subnetwork of the AI compute instance"
}

variable "region" {
  type = string
  description = "The region of the AI compute instance"
}

variable "tags" {
  type = list(string)
  description = "The tags of the AI compute instance"
}

variable "service_account_email" {
  type = string
  description = "The service account email of the AI compute instance"
}

variable "ssh_key_path" {
  type = string
  description = "The SSH key path of the AI compute instance"
}