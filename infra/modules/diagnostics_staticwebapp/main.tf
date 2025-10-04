resource "azurerm_monitor_diagnostic_setting" "staticwebapp_diagnostics" {
  name                       = "clue-sip-staticwebapp-diag"
  target_resource_id         = var.staticwebapp_id
  log_analytics_workspace_id = var.workspace_id

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
