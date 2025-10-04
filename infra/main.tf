resource "azurerm_resource_group" "main" {
  name     = "${var.project_name}-rg"
  location = var.location
}

# SQL Module
module "sql" {
  source              = "./modules/sql"
  project_name        = var.project_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  sql_admin_password  = var.sql_admin_password
  client_ip           = var.client_ip

  # Pass audit vars through
  audit_storage_endpoint = var.audit_storage_endpoint
  audit_storage_key      = var.audit_storage_key

  tags = var.tags
}

# Key Vault Module
module "keyvault" {
  source              = "./modules/keyvault"
  project_name        = var.project_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  sql_admin_password = var.sql_admin_password
  sql_server_fqdn    = module.sql.sql_server_fqdn
  sql_database_name  = module.sql.sql_database_name
  tags               = var.tags
}

# App Service Module
module "appservice" {
  source                           = "./modules/appservice"
  project_name                     = var.project_name
  location                         = var.location
  resource_group_name              = azurerm_resource_group.main.name
  sql_connection_string_secret_uri = module.keyvault.sql_connection_string_secret_uri
  tags                             = var.tags
}

# Static Web App Module
module "staticwebapp" {
  source              = "./modules/staticwebapp"
  project_name        = var.project_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

# App Insights + Log Analytics Module
module "appinsights" {
  source              = "./modules/appinsights"
  project_name        = var.project_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

# Policy Module
module "policy" {
  source       = "./modules/policy"
  project_name = var.project_name
  scope        = azurerm_resource_group.main.id
}

# Diagnostics Module (App Service → Log Analytics)
module "diagnostics" {
  source        = "./modules/diagnostics"
  workspace_id  = module.appinsights.log_analytics_workspace_id
  appservice_id = module.appservice.webapp_id
}

# Diagnostics Module (Static Web App → Log Analytics)
module "diagnostics_staticwebapp" {
  source          = "./modules/diagnostics_staticwebapp"
  workspace_id    = module.appinsights.log_analytics_workspace_id
  staticwebapp_id = module.staticwebapp.static_web_app_id
}

# Diagnostics Module (Key Vault → Log Analytics)
module "diagnostics_keyvault" {
  source       = "./modules/diagnostics_keyvault"
  workspace_id = module.appinsights.log_analytics_workspace_id
  keyvault_id  = module.keyvault.key_vault_id
}

# Diagnostics Module (SQL Database → Log Analytics)
module "diagnostics_sql" {
  source          = "./modules/diagnostics_sql"
  workspace_id    = module.appinsights.log_analytics_workspace_id
  sql_database_id = module.sql.sql_database_id
}
