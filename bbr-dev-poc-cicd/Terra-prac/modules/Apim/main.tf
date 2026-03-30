###############################################
# Random suffix & APIM service
###############################################
resource "random_string" "suffix" {
  length  = 4
  lower   = true
  upper   = false
  numeric = true
  special = false
}

locals {
  computed_apim_name = var.apim_name != "" ? var.apim_name : "apim-${var.env}-${random_string.suffix.result}"
}

resource "azurerm_api_management" "apim" {
  name                = local.computed_apim_name
  location            = var.location
  resource_group_name = var.resource_group_name

  publisher_name  = var.publisher_name
  publisher_email = var.publisher_email
  sku_name        = var.sku_name

  tags = merge(var.tags, { env = var.env })
}

###############################################
# API shell (subscription keys enforced)
###############################################
resource "azurerm_api_management_api" "api" {
  name                 = var.api_name
  display_name         = var.api_display_name
  path                 = var.api_path
  api_management_name  = azurerm_api_management.apim.name
  resource_group_name  = var.resource_group_name

  # REQUIRED in azurerm v4.x
  revision             = "1"

  protocols            = ["https", "http"]
  service_url          = var.service_url

  # 👇 This enforces Ocp-Apim-Subscription-Key
  subscription_required = true
}

resource "azurerm_api_management_api_operation" "create_form" {
  operation_id        = "create-form"
  api_name            = azurerm_api_management_api.api.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group_name

  display_name = "Create Form"
  method       = "POST"
  url_template = "/create_form"
  description  = "Proxies to ApyHub Reformify Create Form endpoint"
}

###############################################
# Product & Subscription (generates subscription keys)
###############################################
# Product to group APIs and issue subscriptions (keys)
resource "azurerm_api_management_product" "basic" {
  product_id          = "${var.env}-basic"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group_name

  display_name         = "Basic (${var.env})"
  description          = "Basic access via APIM subscription key"
  subscription_required = true
  approval_required     = false
  published             = true
  terms                 = "Use of this API is subject to terms defined by the owner."
}

# Attach the API to the product
resource "azurerm_api_management_product_api" "basic_api" {
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group_name
  product_id          = azurerm_api_management_product.basic.product_id
  api_name            = azurerm_api_management_api.api.name
}

# Create a subscription under the product to generate keys
resource "azurerm_api_management_subscription" "client_sub" {
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group_name

  # Link to the Product (best practice)
  product_id   = azurerm_api_management_product.basic.id
  display_name = "${var.env}-postman-client"
  state        = "active"
}

###############################################
# Policy (optional)
###############################################
# APIM enforces subscription key automatically; policy can be omitted.
# If you want a minimal policy, you can use this:
#
# resource "azurerm_api_management_api_policy" "api_policy" {
#   api_management_name = azurerm_api_management.apim.name
#   api_name            = azurerm_api_management_api.api.name
#   resource_group_name = var.resource_group_name
#
#   xml_content = <<XML
# <policies>
#   <inbound>
#     <base />
#   </inbound>
#   <backend>
#     <base />
#   </backend>
#   <outbound>
#     <base />
#   </outbound>
#   <on-error>
#     <base />
#   </on-error>
# </policies>
# XML
# }