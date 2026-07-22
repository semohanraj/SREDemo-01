terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # State is stored locally and committed to the Git repository (GitHub).
  # No remote backend is configured.
}

provider "azurerm" {
  features {}
}
