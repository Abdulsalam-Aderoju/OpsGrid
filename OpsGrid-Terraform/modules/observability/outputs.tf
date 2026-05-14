output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.opsgrid.id
}

output "app_insights_connection_string" {
  value     = azurerm_application_insights.opsgrid.connection_string
  sensitive = true
}

output "app_insights_instrumentation_key" {
  value     = azurerm_application_insights.opsgrid.instrumentation_key
  sensitive = true
}