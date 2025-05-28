variable "location" {
  type = string
}

variable "apply_topic_name" {
  type = string
}

variable "destroy_topic_name" {
  type = string
}

variable "apply_trigger_name" {
  type = string
}

variable "destroy_trigger_name" {
  type = string
}

variable "apply_schedule_name" {
  type = string
}

variable "destroy_schedule_name" {
  type = string
}

variable "apply_cron" {
  type = string
}

variable "destroy_cron" {
  type = string
}

variable "time_zone" {
  type = string
  default = "Asia/Seoul"
}

variable "bucket_name" {
  type = string
}

variable "backup_bucket_name" {
  type = string
}