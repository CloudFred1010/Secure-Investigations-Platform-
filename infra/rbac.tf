data "azurerm_client_config" "current" {}

# Allow the App Service (Linux Web App) to read secrets from Key Vault via RBAC
resource "azurerm_role_assignment" "appservice_kv" {
  scope                = module.keyvault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.appservice.principal_id
}

variable "devops_sp_object_id" {
  description = "Object ID of the Azure DevOps service principal"
  type        = string
}

# Allow Azure DevOps Service Principal to manage secrets via RBAC
resource "azurerm_role_assignment" "pipeline_kv" {
  scope                = module.keyvault.key_vault_id
  role_definition_name = "Key Vault Secrets Officer" # can read/write/delete secrets
  principal_id         = var.devops_sp_object_id
}
