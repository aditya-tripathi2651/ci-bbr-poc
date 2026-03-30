output "storage_blob_endpoint" {
  value = module.storage.primary_blob_endpoint
}

output "vm_id" {
  value = module.vm.vm_id
}

output "vm_public_ip" {
  value       = module.vm.public_ip
  description = "Null if public IP is disabled"
}


output "resource_group" {
  value       = data.azurerm_resource_group.core_rg.name
  description = "The single RG used across the environment"
}

output "Apim_name" { value = module.Apim.apim_name }
output "Apim_gateway_url" { value = module.Apim.gateway_url }
output "Apim_sub_key" {
  value     = module.Apim.subscription_primary_key
  sensitive = true
}
# Root outputs that expose module outputs

output "Apim_subscription_key" {
  value       = module.Apim.subscription_primary_key
  sensitive   = true
  description = "Primary subscription key for APIM product subscription"
}

