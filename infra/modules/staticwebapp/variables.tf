variable "project_name" {
  description = "Project identifier prefix used in naming the static web app"
  type        = string
}

variable "location" {
  description = "Azure region where the static web app will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the static web app will be deployed"
  type        = string
}

variable "tags" {
  description = "Tags applied to the static web app resources"
  type        = map(string)
  default     = {}
}
