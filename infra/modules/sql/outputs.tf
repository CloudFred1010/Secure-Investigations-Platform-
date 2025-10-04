output "sql_server_name" {
  description = "The name of the SQL Server"
  value       = azurerm_mssql_server.this.name
}

output "sql_database_name" {
  description = "The name of the SQL Database"
  value       = azurerm_mssql_database.this.name
}

output "sql_server_fqdn" {
  description = "The fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "sql_connection_string" {
  description = "The connection string for the SQL Database (includes admin user and password)"
  value       = "Server=${azurerm_mssql_server.this.fully_qualified_domain_name};Database=${azurerm_mssql_database.this.name};User ID=sqladminuser;Password=${var.sql_admin_password};"
  sensitive   = true
}

output "allowed_client_ip" {
  description = "The client IP allowed through the SQL firewall"
  value       = var.client_ip
}

output "sql_database_id" {
  description = "The resource ID of the SQL Database"
  value       = azurerm_mssql_database.this.id
}
