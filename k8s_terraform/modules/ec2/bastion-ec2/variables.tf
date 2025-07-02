variable "ami_id" {
  description = "AMI ID"
  type = string
}

variable "instance_type" {
  description = "Instance type"
  type = string
}

variable "security_group_ids" {
  description = "The security group ids for bastion instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "Subnet ID"
  type = string
}

variable "key_name" {
  description = "Key name"
  type = string
}

variable "region" {
  description = "Region"
  type = string
}