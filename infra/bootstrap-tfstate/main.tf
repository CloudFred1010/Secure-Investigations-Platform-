terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource group for remote state
resource "azurerm_resource_group" "tfstate" {
  name     = "clue-sip-tfstate-rg"
  location = "uksouth"
}

# Storage account for Terraform state
resource "azurerm_storage_account" "tfstate" {
  name                     = "cluesiptfstate"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Hardening
  allow_blob_public_access  = false
  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true

  # Disable shared key auth (enforce AAD auth instead)
  shared_access_key_enabled = false

  # Enable soft-delete to recover deleted blobs (7 days)
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  tags = {
    environment = "platform"
    project     = "clue-sip"
  }
}

# Container for Terraform state
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
