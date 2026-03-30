variable "project" {
  description = "Project short name (used in resource names)"
  type        = string
}

variable "env" {
  description = "Environment name (dev|qa|prod)"
  type        = string
}

variable "resource_group_name" {
  description = "Existing Resource Group where resources will be deployed"
  type        = string
}

variable "location" {
  description = "Azure region (e.g., Central India)"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

# ACR
variable "acr_name" {
  description = "Globally unique ACR name (lowercase, 5-50 chars)"
  type        = string
}

variable "acr_sku" {
  description = "ACR SKU (Basic|Standard|Premium)"
  type        = string
  default     = "Basic"
}

# ACA sizing and env vars
variable "min_replicas" {
  description = "Minimum replicas for Container App"
  type        = number
  default     = 1
}

variable "max_replicas" {
  description = "Maximum replicas for Container App"
  type        = number
  default     = 2
}

variable "cpu" {
  description = "vCPU per container (e.g., 0.25, 0.5, 1.0)"
  type        = number
  default     = 0.5
}

variable "memory_gi" {
  description = "Memory in Gi per container (e.g., 1, 2, 4)"
  type        = number
  default     = 1
}

variable "env_vars" {
  description = "Non-secret environment variables for the container (name => value)"
  type        = map(string)
  default     = {}
}

variable "public_image" {
  description = "Public container image to deploy for now (e.g., 'nginx:alpine')"
  type        = string
  default     = "nginx:alpine"
}
