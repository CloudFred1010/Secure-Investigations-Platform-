variable "project_name" {
  description = "Project identifier prefix"
  type        = string
}

variable "location" {
  description = "Azure region for Key Vault deployment"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where Key Vault will be deployed"
  type        = string
}

variable "sql_admin_password" {
  description = "SQL Server admin password to store in Key Vault"
  type        = string
  sensitive   = true
}

variable "sql_server_fqdn" {
  description = "SQL Server fully qualified domain name"
  type        = string
}

variable "sql_database_name" {
  description = "SQL Database name"
  type        = string
}

variable "tags" {
  description = "Common resource tags for Key Vault and secrets"
  type        = map(string)
  default     = {}
}
