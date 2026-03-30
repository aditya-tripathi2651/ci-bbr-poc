# -------------------------------------------------
# Log Analytics Workspace (required by ACA Environment)
# -------------------------------------------------
resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-${var.project}-${var.env}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}

# -------------------------------------------------
# Azure Container Apps Environment
#   Use the modern field: log_analytics_workspace_id
# -------------------------------------------------
resource "azurerm_container_app_environment" "aca_env" {
  name                = "cae-${var.project}-${var.env}"
  resource_group_name = var.resource_group_name
  location            = var.location

  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  tags = var.tags
}

# -------------------------------------------------
# Azure Container App
#   Uses a PUBLIC image now (e.g., nginx:alpine)
# -------------------------------------------------
resource "azurerm_container_app" "aca" {
  name                         = "aca-${var.project}-${var.env}"
  resource_group_name          = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.aca_env.id
  revision_mode                = "Single"

  ingress {
    external_enabled = true
    target_port      = 80

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  template {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    container {
      name   = "app"
      image  = var.public_image                 # e.g., "nginx:alpine"
      cpu    = var.cpu                          # e.g., 0.5
      memory = "${var.memory_gi}Gi"             # e.g., "1Gi"

      dynamic "env" {
        for_each = var.env_vars
        content {
          name  = env.key
          value = env.value
        }
      }
    }
  }

  tags = var.tags
}