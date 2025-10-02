variable "project_name" {
  description = "Project identifier prefix"
  type        = string
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name to deploy resources into"
  type        = string
}

variable "sql_admin_password" {
  description = "SQL Server administrator password"
  type        = string
  sensitive   = true
}

variable "client_ip" {
  description = "Your public IP address to allow through the SQL firewall"
  type        = string
}

variable "audit_storage_endpoint" {
  description = "Blob storage endpoint used to store SQL audit logs"
  type        = string
}

variable "audit_storage_key" {
  description = "Access key for the storage account used for SQL audit logs"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    environment = "dev"
    project     = "clue-sip"
  }
}
