variable "project_id" {
  description = "The project ID to deploy resources into"
  type        = string
  default     = "marong-459104"
}

variable "ssh_key_path" {
  description = "Path to the SSH public key file"
  type        = string
}

variable "service_account_email" {
  description = "The service account email to use for the compute instances"
  type        = string
}