output "appservice_diagnostics_id" {
  description = "The ID of the diagnostics setting for App Service"
  value       = azurerm_monitor_diagnostic_setting.appservice_diagnostics.id
}
