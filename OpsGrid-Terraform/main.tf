terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-opsgrid-state"
    storage_account_name = "opsgridtfstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}



data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "opsgrid" {
  name     = "rg-opsgrid"
  location = "southafricanorth"
}

resource "azurerm_key_vault" "opsgrid" {
  name                = "opsgrid-kv"
  location            = azurerm_resource_group.opsgrid.location
  resource_group_name = azurerm_resource_group.opsgrid.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "Set", "List", "Delete", "Purge"
    ]
  }
}


data "azurerm_key_vault_secret" "db_password" {
  name         = "db-password"
  key_vault_id = azurerm_key_vault.opsgrid.id
}

output "db_password_exists" {
  value     = data.azurerm_key_vault_secret.db_password.id != "" ? "Secret found in Key Vault" : "Not found"
  sensitive = false
}