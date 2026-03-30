
output "resource_group" {
  value = data.azurerm_resource_group.rg.name
}

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