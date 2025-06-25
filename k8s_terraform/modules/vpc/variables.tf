variable "name" {
  description = "VPC 이름"
  type = string
  default = "marong-vpc"
}

variable "cidr_block" {
  description = "VPC CIDR 블록"
  type = string
  default = "10.0.0.0/16"
}