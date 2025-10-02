resource "azurerm_service_plan" "this" {
  name                = "${var.project_name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"

  # For PoC you can leave B1, but production should be S1 or higher
  sku_name = "B1"

  tags = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = "${var.project_name}-web"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  https_only = true # Enforce HTTPS

  site_config {
    ftps_state        = "Disabled"
    http2_enabled     = true
    health_check_path = "/health"
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "DB_CONNECTION_STRING" = "@Microsoft.KeyVault(SecretUri=${var.sql_connection_string_secret_uri})"
  }

  tags = var.tags
}
