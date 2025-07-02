variable "security_group_id" {
  description = "ALB security group id"
  type        = string
}

variable "subnet_ids" {
  description = "ALB subnet ids"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "target_instance_ids" {
  description = "Target instance ids for ALB target group attachment"
  type        = list(string)
}