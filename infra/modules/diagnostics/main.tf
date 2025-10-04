resource "azurerm_monitor_diagnostic_setting" "appservice_diagnostics" {
  name                       = "clue-sip-appservice-diag"
  target_resource_id         = var.appservice_id
  log_analytics_workspace_id = var.workspace_id

  enabled_log {
    category = "AppServiceHTTPLogs"
  }

  enabled_log {
    category = "AppServiceConsoleLogs"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
