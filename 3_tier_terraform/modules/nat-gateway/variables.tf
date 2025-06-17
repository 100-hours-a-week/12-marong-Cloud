variable "name" {
    description = "The name of the NAT gateway"
    type = string
}

variable "network" {
    description = "The network of the NAT gateway"
    type = string
}

variable "region" {
    description = "The region of the NAT gateway"
    type = string
}

variable "private_subnets" {
    description = "List of private subnet names to apply NAT"
    type = list(string)
}
