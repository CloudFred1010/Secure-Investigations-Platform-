output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "app_service_plan_name" {
  description = "Name of the App Service Plan"
  value       = module.appservice.app_service_plan_name
}

output "webapp_url" {
  description = "Default URL of the Web App"
  value       = module.appservice.webapp_default_hostname
}

output "sql_server_name" {
  description = "SQL Server name"
  value       = module.sql.sql_server_name
}

output "sql_database_name" {
  description = "SQL Database name"
  value       = module.sql.sql_database_name
}

output "sql_connection_string" {
  description = "Full SQL connection string (for debugging only — App Service uses Key Vault reference)"
  value       = module.sql.sql_connection_string
  sensitive   = true
}

output "sql_admin_password_secret_uri" {
  description = "Key Vault secret URI for SQL admin password"
  value       = module.keyvault.sql_admin_password_secret_uri
  sensitive   = true
}

output "sql_connection_string_secret_uri" {
  description = "Key Vault secret URI for SQL connection string (used by App Service)"
  value       = module.keyvault.sql_connection_string_secret_uri
  sensitive   = true
}

output "static_web_app_url" {
  description = "Frontend Static Web App URL"
  value       = module.staticwebapp.static_site_url
}

# Application Insights + Log Analytics outputs
output "app_insights_name" {
  description = "Name of Application Insights"
  value       = module.appinsights.app_insights_name
}

output "app_insights_connection_string" {
  description = "Connection string for Application Insights"
  value       = module.appinsights.app_insights_connection_string
  sensitive   = true
}

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = module.appinsights.log_analytics_workspace_id
}

output "log_analytics_workspace_name" {
  description = "Name of Log Analytics workspace"
  value       = module.appinsights.log_analytics_workspace_name
}

# Diagnostics outputs
output "appservice_diagnostics_id" {
  description = "ID of the App Service diagnostics setting"
  value       = module.diagnostics.appservice_diagnostics_id
}

output "staticwebapp_diagnostics_id" {
  description = "ID of the Static Web App diagnostics setting"
  value       = module.diagnostics_staticwebapp.staticwebapp_diagnostics_id
}

output "keyvault_diagnostics_id" {
  description = "ID of the Key Vault diagnostics setting"
  value       = module.diagnostics_keyvault.keyvault_diagnostics_id
}

output "sql_diagnostics_id" {
  description = "ID of the SQL Database diagnostics setting"
  value       = module.diagnostics_sql.sql_diagnostics_id
}
