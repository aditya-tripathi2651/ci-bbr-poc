output "apim_name"   { value = azurerm_api_management.apim.name }
output "gateway_url" { value = azurerm_api_management.apim.gateway_url }


output "product_id" {
  value       = azurerm_api_management_product.basic.product_id
  description = "Product id"
}

output "subscription_primary_key" {
  value       = azurerm_api_management_subscription.client_sub.primary_key
  sensitive   = true
  description = "Primary subscription key"
}

output "subscription_secondary_key" {
  value       = azurerm_api_management_subscription.client_sub.secondary_key
  sensitive   = true
  description = "Secondary subscription key"
}
