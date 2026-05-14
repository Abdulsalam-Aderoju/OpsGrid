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
    key                  = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "dev" {
  name     = "rg-opsgrid-dev"
  location = "southafricanorth"
}

module "networking" {
  source              = "../../modules/networking"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  environment         = "dev"
  vnet_address_space  = "10.0.0.0/16"
  aks_subnet_prefix   = "10.0.1.0/24"
}

module "acr" {
  source              = "../../modules/acr"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  environment         = "dev"
}

module "aks" {
  source              = "../../modules/aks"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  environment         = "dev"
  aks_subnet_id       = module.networking.aks_subnet_id
  node_count          = 1
  node_vm_size        = "Standard_B2als_v2"
  acr_id              = module.acr.acr_id
}

module "keyvault" {
  source                = "../../modules/keyvault"
  resource_group_name   = azurerm_resource_group.dev.name
  location              = azurerm_resource_group.dev.location
  environment           = "dev"
  tenant_id             = data.azurerm_client_config.current.tenant_id
  object_id             = data.azurerm_client_config.current.object_id
  aks_kubelet_object_id = module.aks.kubelet_identity_object_id
}

module "observability" {
  source              = "../../modules/observability"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  environment         = "dev"
}

