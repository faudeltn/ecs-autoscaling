variable "create" {
  description = "Determines whether to create autoscaling group or not"
  type        = bool
  default     = true
}


variable "cluster_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "timezone" {
  type = string
  default = "Europe/Rome"
}

variable "min_capacity" {
  type = string
  default = 1
}

variable "max_capacity" {
  type = string
  default = 1
}

variable "scale_out_action" {
  type = map(string)
  default = {
    name         = "scale-out-action"
    schedule     = "cron(50 8 * * ? *)" # every day at 8:50
    min_capacity = 2
    max_capacity = 2
  }
}

variable "scale_in_action" {
  type = map(string)
  default = {
    name         = "scale-in-action"
    schedule     = "cron(10 18 * * ? *)" # every day at 18:10
    min_capacity = 1
    max_capacity = 1
  }
}
