
resource "azurerm_storage_account" "this" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  location                  = var.location

  account_tier              = var.account_tier
  account_replication_type  = var.replication_type

  # NOTE:
  # - Do NOT set https_traffic_only / enable_https_traffic_only here (schema differs across versions)
  # - Do NOT set allow_blob_public_access here (moved/changed across versions)
  # - We'll enforce network restrictions using the separate resource below

  tags = var.tags
}

# v4-stable approach: manage firewall rules via a dedicated resource
resource "azurerm_storage_account_network_rules" "this" {
  storage_account_id        = azurerm_storage_account.this.id

  # Default deny ensures secure posture
  default_action            = "Deny"

  # Allow Azure Services bypass if you need platform operations (optional)
  bypass                    = ["AzureServices"]

  # Pass IP CIDRs from variables; can be [] safely
  ip_rules                  = var.ip_rules

  # Optional: restrict to VNets later
  # virtual_network_subnet_ids = var.virtual_network_subnet_ids
}


resource "azurerm_storage_container" "containers" {
  for_each               = toset(var.containers)
  name                   = each.value
  # was: storage_account_name  = azurerm_storage_account.this.name
  storage_account_id     = azurerm_storage_account.this.id
  container_access_type  = "private"
}

