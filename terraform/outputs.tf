output "resource_group_name" {
  description = "Name of the created resource group."
  value       = azurerm_resource_group.this.name
}

output "vnet_id" {
  description = "Resource ID of the virtual network."
  value       = module.network.vnet_id
}

output "subnet_ids" {
  description = "Map of subnet name => subnet ID."
  value       = module.network.subnet_ids
}

output "vm_ids" {
  description = "Map of VM name => VM resource ID."
  value       = module.compute.vm_ids
}

output "vm_private_ips" {
  description = "Map of VM name => private IP address."
  value       = module.compute.vm_private_ips
}
