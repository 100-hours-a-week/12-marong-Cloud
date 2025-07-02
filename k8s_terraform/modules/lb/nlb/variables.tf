variable "security_group_id" {
  description = "NLB security group id"
  type        = string
}

variable "subnet_ids" {
  description = "NLB subnet ids"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "target_instance_ids" {
  description = "Target instance ids for NLB target group attachment"
  type        = list(string)
}
