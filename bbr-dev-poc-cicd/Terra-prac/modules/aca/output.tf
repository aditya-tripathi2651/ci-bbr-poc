# output "acr_login_server" {
#   description = "ACR login server (use later when switching ACA to ACR images)"
#   value       = azurerm_container_registry.acr.login_server
# }

output "aca_environment_id" {
  description = "Resource ID of the Container Apps Environment"
  value       = azurerm_container_app_environment.aca_env.id
}

output "aca_name" {
  description = "Container App name"
  value       = azurerm_container_app.aca.name
}

output "aca_fqdn" {
  description = "Public FQDN of the Container App (if ingress enabled)"
  value       = try(azurerm_container_app.aca.latest_revision_fqdn, null)
}