variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the VMs are created."
}

variable "location" {
  type        = string
  description = "Azure region for the VMs."
}

variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet name => subnet ID. Each VM references one of these by name."
}

variable "vms" {
  type = map(object({
    size   = string
    subnet = string
  }))
  description = "Map of VM name => configuration (size and target subnet name)."
}

variable "admin_username" {
  type        = string
  description = "Administrator username for the Windows VMs."
}

variable "admin_password" {
  type        = string
  description = "Administrator password for the Windows VMs."
  sensitive   = true
}

variable "os_disk_type" {
  type        = string
  description = "Managed disk type for the OS disk."
  default     = "Premium_LRS"
}

variable "image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "Windows source image reference."
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to compute resources."
  default     = {}
}
