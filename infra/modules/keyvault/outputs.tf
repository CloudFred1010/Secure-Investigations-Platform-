# Expose Key Vault name
output "key_vault_name" {
  description = "The name of the Key Vault"
  value       = azurerm_key_vault.this.name
}

# Expose Key Vault ID (single output only)
output "key_vault_id" {
  description = "The resource ID of the Key Vault"
  value       = azurerm_key_vault.this.id
}

# Expose Key Vault URI
output "key_vault_uri" {
  description = "The base URI of the Key Vault (used for Key Vault references in App Services)"
  value       = azurerm_key_vault.this.vault_uri
}

# (Optional) Expose secret URIs as strings (not managed by Terraform)
output "sql_admin_password_secret_uri" {
  description = "The versionless URI of the SQL admin password secret in Key Vault"
  value       = "${azurerm_key_vault.this.vault_uri}secrets/sql-admin-password/"
  sensitive   = true
}

output "sql_connection_string_secret_uri" {
  description = "The versionless URI of the SQL connection string secret in Key Vault"
  value       = "${azurerm_key_vault.this.vault_uri}secrets/sql-connection-string/"
  sensitive   = true
}
