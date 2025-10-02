output "staticwebapp_diagnostics_id" {
  description = "The ID of the diagnostics setting for Static Web App"
  value       = azurerm_monitor_diagnostic_setting.staticwebapp_diagnostics.id
}
