resource "azurerm_monitor_diagnostic_setting" "sql_diagnostics" {
  name                       = "clue-sip-sqldb-diag"
  target_resource_id         = var.sql_database_id
  log_analytics_workspace_id = var.workspace_id

  enabled_log {
    category = "SQLInsights"
  }

  enabled_log {
    category = "AutomaticTuning"
  }

  enabled_log {
    category = "QueryStoreRuntimeStatistics"
  }

  enabled_log {
    category = "QueryStoreWaitStatistics"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
