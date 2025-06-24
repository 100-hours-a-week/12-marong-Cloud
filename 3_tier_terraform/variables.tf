variable "project_id" {
  description = "The project ID to deploy resources into"
  type        = string
  default     = "marong-463804"
}

variable "ssh_key_path" {
  description = "Path to the SSH public key file"
  type        = string
}

variable "service_account_email" {
  description = "The service account email to use for the compute instances"
  type        = string
}

# variable "bucket_name" {
#   description = "The name of the GCS bucket to use for the storage"
#   type        = string
# }

# variable "backup_bucket_name" {
#   description = "The name of the backup GCS bucket to use for the storage"
#   type        = string
# }