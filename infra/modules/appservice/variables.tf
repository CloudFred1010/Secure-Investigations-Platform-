variable "project_name" {
  description = "Project identifier prefix for naming App Service resources"
  type        = string
}

variable "location" {
  description = "Azure region where the App Service resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where the App Service will be deployed"
  type        = string
}

variable "sql_connection_string_secret_uri" {
  description = "Key Vault secret URI for the SQL connection string used by the Web App"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Common tags applied to App Service resources"
  type        = map(string)
  default     = {}
}
