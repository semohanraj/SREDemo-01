# Copy this file to terraform.tfvars and adjust as needed.
resource_group_name = "rg-sreagent-vms"
location            = "swedencentral"

vnet_name          = "vnet-sreagent"
vnet_address_space = ["172.21.0.0/22"]

subnets = {
  web = { address_prefix = "172.21.0.0/24" }
  app = { address_prefix = "172.21.1.0/24" }
  db  = { address_prefix = "172.21.2.0/24" }
}

vms = {
  "vm-f8s-01"     = { size = "Standard_F8s_v2", subnet = "app" }
  "vm-f8s-02"     = { size = "Standard_F8s_v2", subnet = "app" }
  "vm-e4s-01"     = { size = "Standard_E4s_v2", subnet = "app" }
  "vm-e4s-02"     = { size = "Standard_E4s_v2", subnet = "app" }
  "vm-b4s-01"     = { size = "Standard_B4s_v2", subnet = "app" }
  "vm-f4s-web-01" = { size = "Standard_F4s_v2", subnet = "web" }
}

admin_username = "azureadmin"
# admin_password is intentionally omitted. Provide it at runtime:
#   PowerShell: $env:TF_VAR_admin_password = "<strong-password>"
#   bash:       export TF_VAR_admin_password="<strong-password>"
