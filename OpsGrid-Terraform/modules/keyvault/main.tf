resource "azurerm_key_vault" "opsgrid_env" {
  name                = "opsgrid-kv-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    secret_permissions = [
      "Get", "Set", "List", "Delete", "Purge"
    ]
  }

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.aks_kubelet_object_id

    secret_permissions = [
      "Get", "List"
    ]
  }
}