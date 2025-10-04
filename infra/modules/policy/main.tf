terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.5"
    }
  }
}

provider "azurerm" {
  features {}
}

# Enforce mandatory tags policy
resource "azurerm_policy_definition" "enforce_tags" {
  name         = "${var.project_name}-enforce-tags"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Enforce mandatory tags (environment, project)"

  policy_rule = jsonencode({
    if = {
      anyOf = [
        { field = "tags.environment", equals = "" },
        { field = "tags.project", equals = "" }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}

# Restrict allowed regions policy
resource "azurerm_policy_definition" "allowed_locations" {
  name         = "${var.project_name}-allowed-locations"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Restrict allowed regions"

  policy_rule = jsonencode({
    if = {
      field = "location"
      notIn = ["uksouth", "westeurope"]
    }
    then = {
      effect = "deny"
    }
  })
}

# Assignment for tag enforcement policy
resource "azapi_resource" "tags_assignment" {
  type      = "Microsoft.Authorization/policyAssignments@2021-06-01"
  name      = "${var.project_name}-tags-assignment"
  parent_id = var.scope

  body = jsonencode({
    properties = {
      displayName        = "Enforce tags assignment"
      policyDefinitionId = azurerm_policy_definition.enforce_tags.id
    }
  })
}

# Assignment for allowed locations policy
resource "azapi_resource" "location_assignment" {
  type      = "Microsoft.Authorization/policyAssignments@2021-06-01"
  name      = "${var.project_name}-location-assignment"
  parent_id = var.scope

  body = jsonencode({
    properties = {
      displayName        = "Allowed locations assignment"
      policyDefinitionId = azurerm_policy_definition.allowed_locations.id
    }
  })
}
