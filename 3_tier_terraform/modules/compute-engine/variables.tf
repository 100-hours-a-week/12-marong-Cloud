variable "name" {
    description = "The name of the instance"
    type = string
}

variable "machine_type" {
    description = "The machine type of the instance"
    type = string
}

variable "zone" {
    description = "The zone of the instance"
    type = string
}

variable "image" {
    description = "The image of the instance"
    type = string
}

variable "disk_size" {
    description = "The size of the disk"
    type = number
}

variable "subnetwork" {
    description = "The subnetwork of the instance"
    type = string
}

variable "ssh_key_path" {
    description = "The path to the SSH key"
    type = string
}

variable "tags" {
    description = "The tags of the instance"
    type = list(string)
}

variable "service_account_email" {
    description = "The email of the service account"
    type = string
    default = ""
}