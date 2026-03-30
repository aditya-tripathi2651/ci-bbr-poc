locals {
  location = data.azurerm_resource_group.core_rg.location

  tags = {
    environment = "dev"
    owner       = "aditya.tripathi"
    managed_by  = "terraform"
  }

  vnet_name   = "${var.org}-${var.app}-dev-vnet"
  subnet_name = "${var.org}-${var.app}-dev-subnet"


}

