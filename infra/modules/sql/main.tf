resource "azurerm_mssql_server" "this" {
  name                = "${var.project_name}-sqlsrv"
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "12.0"

  administrator_login          = "sqladminuser"
  administrator_login_password = var.sql_admin_password

  minimum_tls_version           = "1.2"
  public_network_access_enabled = false # Disable public access (use private endpoint instead)

  tags = var.tags
}

resource "azurerm_mssql_database" "this" {
  name      = "${var.project_name}-db"
  server_id = azurerm_mssql_server.this.id
  sku_name  = "Basic"
  collation = "SQL_Latin1_General_CP1_CI_AS"

  tags = var.tags
}

# Extended Auditing Policy (logs -> storage account)
resource "azurerm_mssql_server_extended_auditing_policy" "audit" {
  server_id                  = azurerm_mssql_server.this.id
  storage_endpoint           = var.audit_storage_endpoint
  storage_account_access_key = var.audit_storage_key
  retention_in_days          = 90
}

# Security Alerts (SQL threat detection)
resource "azurerm_mssql_server_security_alert_policy" "alerts" {
  server_name         = azurerm_mssql_server.this.name
  resource_group_name = var.resource_group_name
  state               = "Enabled"
}

# Vulnerability Assessment (reuses same storage account)
#resource "azurerm_mssql_server_vulnerability_assessment" "va" {
# server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.alerts.id
#storage_container_path          = "${var.audit_storage_endpoint}/sql-va/"
#storage_account_access_key      = var.audit_storage_key
#}

# Firewall Rule — only allow your client IP
resource "azurerm_mssql_firewall_rule" "allow_client_ip" {
  name             = "AllowClientIP"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = var.client_ip
  end_ip_address   = var.client_ip
}
