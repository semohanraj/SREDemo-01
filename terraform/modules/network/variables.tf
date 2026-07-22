variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the network resources are created."
}

variable "location" {
  type        = string
  description = "Azure region for the network resources."
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network."
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the virtual network."
}

variable "subnets" {
  type = map(object({
    address_prefix = string
  }))
  description = "Map of subnets to create (name => address prefix)."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to network resources."
  default     = {}
}
