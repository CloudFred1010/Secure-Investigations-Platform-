# Fetch current tenant and client info
data "azurerm_client_config" "current" {}

# Create the Key Vault
resource "azurerm_key_vault" "this" {
  name                       = "${var.project_name}-kv"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 90 # best practice
  purge_protection_enabled   = true

  # Security hardening
  public_network_access_enabled = false # no public access

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    # ip_rules can be added later if you want to allow specific office IPs
  }

  tags = var.tags

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]
  }
}

# Store SQL Admin Password in Key Vault
resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password"
  value        = var.sql_admin_password
  key_vault_id = azurerm_key_vault.this.id

  content_type    = "password"
  expiration_date = timeadd(timestamp(), "8760h") # 1 year expiry

  tags = var.tags
}

# Store full SQL connection string in Key Vault
resource "azurerm_key_vault_secret" "sql_connection_string" {
  name         = "sql-connection-string"
  value        = "Server=${var.sql_server_fqdn};Database=${var.sql_database_name};User ID=sqladminuser;Password=${var.sql_admin_password};"
  key_vault_id = azurerm_key_vault.this.id

  content_type    = "connection-string"
  expiration_date = timeadd(timestamp(), "8760h") # 1 year expiry

  tags = var.tags
}
