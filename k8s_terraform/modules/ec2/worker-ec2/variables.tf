variable "worker_count" {
  type = number
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_ids" {
  description = "The list of subnet ids for worker nodes"
  type        = list(string)
}

variable "security_group_ids" {
  description = "The security group ids for worker instance"
  type        = list(string)
}

variable "key_name" {
  description = "The key name for worker instance"
  type        = string
}