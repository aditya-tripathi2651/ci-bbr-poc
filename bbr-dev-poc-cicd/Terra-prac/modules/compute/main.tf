
# Optional Public IP
resource "azurerm_public_ip" "pip" {
  count               = var.create_public_ip ? 1 : 0
  name                = "${var.name}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# NIC
resource "azurerm_network_interface" "nic" {
  name                = "${var.name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.create_public_ip ? azurerm_public_ip.pip[0].id : null
  }

  tags = var.tags
}

# NSG (only when allowed_ssh_cidrs is provided)
resource "azurerm_network_security_group" "nsg" {
  count               = length(var.allowed_ssh_cidrs) > 0 ? 1 : 0
  name                = "${var.name}-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = var.allowed_ssh_cidrs
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "assoc" {
  count                     = length(var.allowed_ssh_cidrs) > 0 ? 1 : 0
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg[0].id
}

# VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size
  admin_username                  = var.admin_username
  network_interface_ids           = [azurerm_network_interface.nic.id]
  disable_password_authentication = true

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    name                 = "${var.name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = var.tags
}
