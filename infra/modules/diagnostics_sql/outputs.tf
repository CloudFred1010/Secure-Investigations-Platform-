output "sql_diagnostics_id" {
  description = "The ID of the diagnostics setting for SQL Database"
  value       = azurerm_monitor_diagnostic_setting.sql_diagnostics.id
}
