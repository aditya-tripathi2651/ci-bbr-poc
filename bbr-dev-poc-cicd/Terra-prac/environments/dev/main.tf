terraform {
  backend "azurerm" {}
}

# Use existing RG only
data "azurerm_resource_group" "core_rg" {
  name = "rg-adityatripathi-poc"
}

# ---------------------------
# Networking
# ---------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = data.azurerm_resource_group.core_rg.name
  location            = local.location
  address_space       = ["10.10.0.0/16"]
  tags                = local.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = local.subnet_name
  resource_group_name  = data.azurerm_resource_group.core_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.10.1.0/24"]
}


# ---------------------------
# Storage (Data module)
# ---------------------------
module "storage" {
  source              = "../../modules/data"
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.core_rg.name
  location            = local.location
  account_tier        = var.sa_account_tier
  replication_type    = var.sa_replication_type
  containers          = var.sa_containers
  ip_rules            = var.sa_ip_rules
  tags                = local.tags
}

# ---------------------------
# Compute (VM module)
# ---------------------------
module "vm" {
  source              = "../../modules/compute"
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.core_rg.name
  location            = local.location
  subnet_id           = azurerm_subnet.subnet.id
  size                = var.vm_size
  admin_username      = "azureuser"
  ssh_public_key      = var.ssh_public_key
  create_public_ip    = var.create_public_ip
  allowed_ssh_cidrs   = var.allowed_ssh_cidrs
  tags                = local.tags
}

# ---------------------------
# APIM (subscription key model)
# ---------------------------
# module "Apim" {
#   source = "../../modules/Apim"

#   env                 = "dev"
#   location            = data.azurerm_resource_group.core_rg.location
#   resource_group_name = data.azurerm_resource_group.core_rg.name

#   publisher_name  = "Aditya Tripathi"
#   publisher_email = "aditya@example.com"
#   apim_name       = "apim-dev-atripathi"
#   sku_name        = "Developer_1"

#   api_name         = "apyhub-reformify-dev"
#   api_display_name = "ApyHub Reformify (Dev)"
#   api_path         = "reformify"
#   service_url      = "https://api.apyhub.com"

#   # ⛔ Removed: tenant_id, audience, issuer, apyhub_token (no JWT/token usage)
#   # ✅ Module handles Product + Subscription to enforce Ocp-Apim-Subscription-Key

#   tags = { owner = "aditya", cost = "poc", env = "dev" }
# }


module "acr" {
  source = "../../modules/acr"
  acr_name            = "adityaacrdev01"        # must be globally unique + lowercase
  resource_group_name = "rg-adityatripathi-poc" # your existing RG
  location            = "centralindia"        #location
  sku                 = "Basic"
  admin_enabled       = false
}
module "keyvault" {
  source = "../../modules/keyvault"
  
}

module "aca" {
  source = "../../modules/aca"
  location            = "centralindia"

  project             = "poc"
env                 = "dev"
resource_group_name = "rg-adityatripathi-poc"  # or your RG

acr_name = "acradiyapoc01"  # must be globally unique, lowercase
tags = { env = "dev", owner = "aditya" }

# ACA currently uses a public image:
public_image = "nginx:alpine"
  
}# trigger
# pipeline trigger Tue, Mar 31, 2026  9:16:51 PM
