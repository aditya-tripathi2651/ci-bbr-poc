variable "acr_name" {
  description = "ACR Name"
  type        = string
}

variable "resource_group_name" {
  description = "Existing RG name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku" {
  description = "ACR SKU"
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Enable admin user"
  type        = bool
  default     = false
}