# Fetch current tenant and client info
data "azurerm_client_config" "current" {}

# Key Vault
resource "azurerm_key_vault" "this" {
  name                       = "${var.project_name}-kv"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  # Keep public access disabled for security (you can toggle for bootstrap if needed)
  public_network_access_enabled = false

  # In production, use private endpoints.
  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }

  tags = var.tags

  # Access policy for Terraform identity
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
