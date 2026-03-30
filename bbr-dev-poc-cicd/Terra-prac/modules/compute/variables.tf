
variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "size" {
  type    = string
  default = "Standard_B2s"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key" {
  type = string
}

variable "create_public_ip" {
  type    = bool
  default = false
}

variable "allowed_ssh_cidrs" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}