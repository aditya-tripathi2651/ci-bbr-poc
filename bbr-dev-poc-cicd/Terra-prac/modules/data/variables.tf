
variable "name" {
  type        = string
  description = "Globally unique storage account name (lowercase, 3-24 chars)"
}

variable "resource_group_name" {
  type        = string
  description = "Existing RG name"
}

variable "location" {
  type        = string
  description = "Azure location (e.g., centralindia)"
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "replication_type" {
  type    = string
  default = "LRS"
}

variable "containers" {
  type    = list(string)
  default = []
}

variable "ip_rules" {
  type        = list(string)
  description = "CIDRs allowed to access storage (optional)"
  default     = []
}

variable "virtual_network_subnet_ids" {
  type        = list(string)
  description = "Optional subnet IDs for network rules (for VNet restrictions)"
  default     = []
}

variable "tags" {
  type    = map(string)
  default = {}
}