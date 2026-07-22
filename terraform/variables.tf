variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to create for all resources."
  default     = "rg-sreagent-vms"
}

variable "location" {
  type        = string
  description = "Azure region for all resources."
  default     = "eastus"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network."
  default     = "vnet-sreagent"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space of the virtual network. Normalized valid CIDR for the requested 172.21.1.0/22 range."
  default     = ["172.21.0.0/22"]
}

variable "subnets" {
  type = map(object({
    address_prefix = string
  }))
  description = "Three equal-sized /24 subnets carved from the /22 VNet."
  default = {
    web = { address_prefix = "172.21.0.0/24" }
    app = { address_prefix = "172.21.1.0/24" }
    db  = { address_prefix = "172.21.2.0/24" }
  }
}

variable "vm_subnet_name" {
  type        = string
  description = "Name of the subnet where all VMs are placed."
  default     = "app"
}

variable "vms" {
  type = map(object({
    size = string
  }))
  description = "Map of VM name => size. All VMs are placed in the app subnet."
  default = {
    "vm-f8s-01" = { size = "Standard_F8s_v2" }
    "vm-f8s-02" = { size = "Standard_F8s_v2" }
    "vm-e4s-01" = { size = "Standard_E4s_v2" }
    "vm-e4s-02" = { size = "Standard_E4s_v2" }
    "vm-b4s-01" = { size = "Standard_B4s_v2" }
  }
}

variable "admin_username" {
  type        = string
  description = "Administrator username for the Windows VMs."
  default     = "azureadmin"
}

variable "admin_password" {
  type        = string
  description = "Administrator password for the Windows VMs. Provide via TF_VAR_admin_password or a secret store; do not commit."
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources."
  default = {
    environment = "sreagent"
    managed_by  = "terraform"
  }
}
