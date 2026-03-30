
terraform {
  backend "azurerm" {}
}

data "azurerm_resource_group" "rg" {
  name = "rg-adityatripathi-poc"
}

locals {
  location = data.azurerm_resource_group.rg.location

  tags = {
    environment = "qa"
    owner       = "aditya.tripathi"
    managed_by  = "terraform"
  }

  vnet_name   = "${var.org}-${var.app}-qa-vnet"
  subnet_name = "${var.org}-${var.app}-qa-subnet"
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
  address_space       = ["10.20.0.0/16"]
  tags                = local.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = local.subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.20.1.0/24"]
}

module "storage" {
  source              = "../../modules/data"
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
  account_tier        = var.sa_account_tier
  replication_type    = var.sa_replication_type
  containers          = var.sa_containers
  ip_rules            = var.sa_ip_rules
  tags                = local.tags
}

module "vm" {
  source              = "../../modules/compute"
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = local.location
  subnet_id           = azurerm_subnet.subnet.id
  size                = var.vm_size
  admin_username      = "azureuser"
  ssh_public_key      = var.ssh_public_key
  create_public_ip    = false
  allowed_ssh_cidrs   = [] # QA: no public SSH
  tags                = local.tags
}