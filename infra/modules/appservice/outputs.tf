output "app_service_plan_name" {
  description = "Name of the App Service Plan"
  value       = azurerm_service_plan.this.name
}

output "webapp_default_hostname" {
  description = "Default hostname of the Web App"
  value       = azurerm_linux_web_app.this.default_hostname
}

output "webapp_id" {
  description = "Resource ID of the Web App (required for diagnostics settings)"
  value       = azurerm_linux_web_app.this.id
}
