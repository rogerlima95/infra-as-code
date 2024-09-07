variable "project_id" {
  type        = string
}

variable "network_name" {
  type        = string
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
}


variable "description" {
  type        = string
  default     = ""
}

variable "auto_create_subnetworks" {
  type        = bool
  default     = false
}

variable "delete_default_internet_gateway_routes" {
  type        = bool
  default     = false
}

variable "mtu" {
  type        = number
  default     = 0
}

variable "enable_ipv6_ula" {
  type        = bool
  default     = false
}

variable "internal_ipv6_range" {
  type        = string
  default     = null
}

variable "network_firewall_policy_enforcement_order" {
  type        = string
  default     = null
}