resource "azurerm_mssql_server" "this" {
  name                = "${var.project_name}-sqlsrv"
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "12.0"

  administrator_login          = "sqladminuser"
  administrator_login_password = var.sql_admin_password

  minimum_tls_version           = "1.2"
  public_network_access_enabled = true # enable for PoC so firewall rules can apply

  tags = var.tags
}

resource "azurerm_mssql_database" "this" {
  name      = "${var.project_name}-db"
  server_id = azurerm_mssql_server.this.id
  sku_name  = "Basic"
  collation = "SQL_Latin1_General_CP1_CI_AS"

  tags = var.tags
}

resource "azurerm_mssql_server_extended_auditing_policy" "audit" {
  server_id                  = azurerm_mssql_server.this.id
  storage_endpoint           = var.audit_storage_endpoint
  storage_account_access_key = var.audit_storage_key
  retention_in_days          = 90
}

resource "azurerm_mssql_server_security_alert_policy" "alerts" {
  server_name         = azurerm_mssql_server.this.name
  resource_group_name = var.resource_group_name
  state               = "Enabled"
}

resource "azurerm_mssql_firewall_rule" "allow_client_ip" {
  name             = "AllowClientIP"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = var.client_ip
  end_ip_address   = var.client_ip
}
