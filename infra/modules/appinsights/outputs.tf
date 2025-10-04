# Application Insights Outputs
output "app_insights_name" {
  description = "Name of the Application Insights instance"
  value       = azurerm_application_insights.this.name
}

output "app_insights_connection_string" {
  description = "Connection string for Application Insights"
  value       = azurerm_application_insights.this.connection_string
  sensitive   = true
}

# Log Analytics Outputs
output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.this.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.this.name
}
