variable "project_name" {
  description = "Project identifier prefix (used in naming all resources)"
  type        = string
  default     = "clue-sip"
}

variable "location" {
  description = "Primary Azure region for most resources (SQL, App Service, Key Vault, etc.)"
  type        = string
  default     = "uksouth"
}

variable "static_web_location" {
  description = "Azure region for Static Web App (must be supported by the service)"
  type        = string
  default     = "westeurope"
}

variable "sql_admin_password" {
  description = "SQL Server administrator password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    environment = "dev"
    project     = "clue-sip"
  }
}

variable "client_ip" {
  description = "Public IPv4 address of the client for SQL firewall access (e.g., 1.2.3.4)"
  type        = string
}

# --- For SQL auditing & vulnerability assessments ---
variable "audit_storage_endpoint" {
  description = "Blob storage endpoint used to store SQL audit logs (e.g., https://mystorage.blob.core.windows.net/)"
  type        = string
}

variable "audit_storage_key" {
  description = "Access key for the storage account used for SQL audit logs"
  type        = string
  sensitive   = true
}
