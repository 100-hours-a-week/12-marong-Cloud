variable "master_count" {
  type = number
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  description = "The subnet id for master node"
  type        = string
}

variable "security_group_ids" {
  description = "The security group ids for master instance"
  type        = list(string)
}

variable "key_name" {
  description = "The key name for master instance"
  type        = string
}