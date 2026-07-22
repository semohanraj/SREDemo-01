# SREAgent — Windows VMs on Azure (Terraform)

Modular Terraform configuration that provisions:

- A resource group
- A virtual network `172.21.0.0/22` (valid CIDR for the requested `172.21.1.0/22`)
- Three equal-sized `/24` subnets: `web`, `app`, `db`
- Five Windows Server 2022 VMs, all placed in the **app** subnet:
  - 2 × `Standard_F8s_v2`
  - 2 × `Standard_E4s_v2`
  - 1 × `Standard_B4s_v2`

## Structure

```
terraform/
├── providers.tf          # Terraform + azurerm provider config
├── main.tf               # Root: resource group + module wiring
├── variables.tf          # Root input variables
├── outputs.tf            # Root outputs
├── example.tfvars        # Sample variable values (copy to terraform.tfvars)
└── modules/
    ├── network/          # VNet + subnets
    └── compute/          # NICs + Windows VMs
```

## Usage

```powershell
cd terraform

# Authenticate (Azure CLI)
az login

# Provide the VM admin password securely (never commit it)
$env:TF_VAR_admin_password = "<strong-password>"

terraform init
terraform plan  -var-file="example.tfvars"
terraform apply -var-file="example.tfvars"
```

## Notes

- The requested `172.21.1.0/22` has host bits set and is not a valid network
  address; it is normalized to `172.21.0.0/22`. Adjust `vnet_address_space` if a
  different range is required.
- `Standard_B4s` is not a valid Azure SKU; `Standard_B4s_v2` is used as the
  closest equivalent. Change it in `vms` if needed.
- `admin_password` must be supplied at runtime via `TF_VAR_admin_password` (or a
  secret store). It is never stored in source control.
- `*.tfvars` files are git-ignored to avoid leaking secrets.
- **State:** Terraform state is stored locally and committed to this GitHub
  repository (no remote backend). The CI `apply` job commits the updated
  `terraform.tfstate` back to `main`.
  **Warning:** state files can contain sensitive values (including the VM admin
  password) in plaintext. Keep this repository **private**.
