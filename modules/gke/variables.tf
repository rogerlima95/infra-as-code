variable "project_id" {
  type        = string
}

variable "cluster_name" {
  type        = string

}

variable "region" {
  type        = string
}

variable "network" {
  type        = string
}

variable "subnetwork" {
  type        = string
}

variable "cidr_block" {
  type        = string
  default     = "0.0.0.0/0"
}

variable "enable_l4_ilb_subsetting" {
    type = bool
    default = true
  
}

variable "deletion_protection" {
  type = bool
  default = false
}