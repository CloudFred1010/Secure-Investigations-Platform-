output "static_site_url" {
  description = "Default URL for the static web app"
  value       = azurerm_static_web_app.this.default_host_name
}

output "static_web_app_id" {
  description = "Resource ID of the Static Web App"
  value       = azurerm_static_web_app.this.id
}
