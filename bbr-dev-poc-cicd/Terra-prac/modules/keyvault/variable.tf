variable "location" {
  description = "Azure region for the Key Vault"
  type        = string
  default     = "Central India"
}

variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
  default     = "kv-adityatripathi-poc"
}

variable "create_sample_secret" {
  description = "Whether to create a sample secret"
  type        = bool
  default     = false
}
variable "resource_group_name" {
    description = "resource-group"
    type = string
    default = "rg-adityatripathi-poc"
}
variable "tenant_id" {
      default = "8af0c5d1-469a-4bc2-8d5f-a6cb3fb0ccd9"
}