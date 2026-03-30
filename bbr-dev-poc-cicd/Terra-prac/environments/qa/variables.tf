
variable "org" {
  type        = string
  description = "Org or project short name"
}

variable "app" {
  type        = string
  description = "Application short name"
}

variable "vm_name" {
  type        = string
  description = "VM name"
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for admin user"
}

variable "create_public_ip" {
  type    = bool
  default = true
}

variable "allowed_ssh_cidrs" {
  type        = list(string)
  description = "CIDRs allowed to SSH into VM (22)"
  default     = []
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique storage account name"
}

variable "sa_account_tier" {
  type    = string
  default = "Standard"
}

variable "sa_replication_type" {
  type    = string
  default = "LRS"
}

variable "sa_containers" {
  type    = list(string)
  default = ["appdata"]
}

variable "sa_ip_rules" {
  type    = list(string)
  default = []
}