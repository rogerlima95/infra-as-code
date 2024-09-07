variable "project_id" {
  type        = string
}

variable "region" {
  type        = string
}

variable "cluster_name" {
  type        = string
}

variable "service_name" {
  type        = string
}

variable "service_port" {
    type = number
    default = 80
}