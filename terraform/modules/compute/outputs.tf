output "vm_ids" {
  description = "Map of VM name => VM resource ID."
  value       = { for name, vm in azurerm_windows_virtual_machine.this : name => vm.id }
}

output "vm_private_ips" {
  description = "Map of VM name => private IP address."
  value       = { for name, nic in azurerm_network_interface.this : name => nic.private_ip_address }
}
