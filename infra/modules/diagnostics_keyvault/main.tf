resource "azurerm_monitor_diagnostic_setting" "keyvault_diagnostics" {
  name                       = "clue-sip-keyvault-diag"
  target_resource_id         = var.keyvault_id
  log_analytics_workspace_id = var.workspace_id

  enabled_log {
    category = "AuditEvent"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
