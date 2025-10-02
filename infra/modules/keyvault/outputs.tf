# Expose Key Vault name
output "key_vault_name" {
  description = "The name of the Key Vault"
  value       = azurerm_key_vault.this.name
}

# Expose Key Vault ID
output "key_vault_id" {
  description = "The resource ID of the Key Vault"
  value       = azurerm_key_vault.this.id
}

# Expose the Secret URI for SQL admin password
output "sql_admin_password_secret_uri" {
  description = "The versionless URI of the SQL admin password secret in Key Vault"
  value       = azurerm_key_vault_secret.sql_admin_password.versionless_id
  sensitive   = true
}

# Expose the Secret URI for SQL connection string
output "sql_connection_string_secret_uri" {
  description = "The versionless URI of the SQL connection string secret in Key Vault"
  value       = azurerm_key_vault_secret.sql_connection_string.versionless_id
  sensitive   = true
}

output "keyvault_id" {
  description = "The resource ID of the Key Vault"
  value       = azurerm_key_vault.this.id
}
