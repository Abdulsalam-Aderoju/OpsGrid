resource "azurerm_log_analytics_workspace" "opsgrid" {
  name                = "law-opsgrid-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "opsgrid" {
  name                = "appi-opsgrid-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.opsgrid.id
  application_type    = "web"
}