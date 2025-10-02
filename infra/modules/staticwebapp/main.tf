resource "azurerm_static_web_app" "this" {
  name                = "${var.project_name}-spa"
  resource_group_name = var.resource_group_name
  location            = "westeurope" # FIX: supported region
  sku_tier            = "Free"

  tags = var.tags
}
