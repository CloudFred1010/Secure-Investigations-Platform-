variable "project_name" {
  description = "Project identifier prefix for naming Application Insights and Log Analytics resources"
  type        = string
}

variable "location" {
  description = "Azure region where Application Insights and Log Analytics will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where monitoring resources will be created"
  type        = string
}

variable "tags" {
  description = "Common tags applied to monitoring resources"
  type        = map(string)
  default     = {}
}
