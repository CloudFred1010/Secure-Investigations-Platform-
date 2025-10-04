# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "this" {
  name                = "${var.project_name}-logs"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}

# Application Insights (linked to Log Analytics)
resource "azurerm_application_insights" "this" {
  name                = "${var.project_name}-appi"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"

  # Link App Insights to Log Analytics
  workspace_id = azurerm_log_analytics_workspace.this.id

  tags = var.tags
}
