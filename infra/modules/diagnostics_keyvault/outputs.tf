output "keyvault_diagnostics_id" {
  description = "The ID of the diagnostics setting for Key Vault"
  value       = azurerm_monitor_diagnostic_setting.keyvault_diagnostics.id
}
