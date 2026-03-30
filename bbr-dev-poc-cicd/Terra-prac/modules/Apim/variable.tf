# ---- Environment name ----
# Used for naming and tagging (dev / qa / prod)
variable "env" {
  description = "dev"
  type        = string
}

# ---- Azure Region ----
# Location where APIM will be deployed
variable "location" {
  description = "centralindia"
  type        = string
}

# ---- Resource Group ----
# Existing Resource Group where APIM will be created
variable "resource_group_name" {
  description = "rg-adityatripathi-poc"
  type        = string
}

# ---- APIM Publisher Details ----
# These appear in APIM portal (required by Azure)
variable "publisher_name" {
  description = "developer portal"
  type        = string
}

variable "publisher_email" {
  description = "atripathi@eci.com"
  type        = string
}

# ---- APIM Service Name ----
# Must be globally unique (used as *.azure-api.net)
# If empty, module generates a name using env + random suffix
variable "apim_name" {
  description = "apim-poc"
  type        = string
  default     = ""
}

# ---- APIM SKU ----
# Developer_1 is best for POC / non-prod
variable "sku_name" {
  description = "APIM SKU name"
  type        = string
  default     = "Developer_1"
}

# ======================
# API CONFIGURATION
# ======================

# ---- Internal API Name in APIM ----
# Used only inside APIM
variable "api_name" {
  description = "APIM API name"
  type        = string
  default     = "apyhub-reformify"
}

# ---- Display Name ----
# Shown in Azure Portal / Developer portal
variable "api_display_name" {
  description = "APIM API display name"
  type        = string
  default     = "ApyHub Reformify API"
}

# ---- API Path ----
# URL path exposed by APIM gateway
# Example: /reformify
variable "api_path" {
  description = "Base path exposed by APIM"
  type        = string
  default     = "reformify"
}

# ---- Backend Service URL ----
# Actual backend endpoint (hidden behind APIM)
variable "service_url" {
  description = "Backend service base URL"
  type        = string
  default     = "https://api.apyhub.com"
}

# ======================
# JWT / ENTRA SETTINGS
# ======================

# ---- Tenant ID ----
# Used by APIM to discover signing keys (OpenID config)
variable "tenant_id" {
  description = "Microsoft Entra Tenant ID"
  type        = string
  default = "8af0c5d1-469a-4bc2-8d5f-a6cb3fb0ccd9"
}

# ---- Audience ----
# Must match the value defined under 'Expose an API'
# Usually: api://<CLIENT_ID>
variable "audience" {
  description = "Expected audience in JWT token"
  type        = string
  default = "api://581aa7cf-c973-47c6-bbd8-83727eed4890"
}

# ---- Issuer ----
# Token issuer URL from Entra
variable "issuer" {
  description = "Expected JWT issuer"
  type        = string
  default = "https://sts.windows.net/8af0c5d1-469a-4bc2-8d5f-a6cb3fb0ccd9/"
}

# ---- Required Role ----
# APIM allows access only if this role exists in JWT
variable "required_role" {
  description = "Required role claim in JWT"
  type        = string
  default     = "Form.Writer"
}

# ======================
# BACKEND AUTH (APYHUB)
# ======================

# ---- ApyHub Token ----
# Secret token forwarded by APIM as 'apy-token' header
# Marked sensitive to avoid logging
# variable "apyhub_token" {
#   description = "ApyHub API token"
#   type        = string
#   sensitive   = true
# }

# ---- Tags ----
# Optional tags applied to APIM resource
variable "tags" {
  description = "Tags for APIM resources"
  type        = map(string)
  default     = {}
}
variable "api_revision" {
  type        = string
  default     = "1"
  description = "APIM API revision string"
}