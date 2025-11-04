provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Reference existing resource group
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Reference existing storage account
data "azurerm_storage_account" "adls" {
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Reference existing container named "stage"
data "azurerm_storage_container" "stage" {
  name                 = "stage"
  storage_account_name = data.azurerm_storage_account.adls.name
}

# Define folders to create inside the "stage" container
locals {
  staging_folders = [
    "frc/pnc/ram/facilities",
    "frc/ny/gis/tline"
  ]
}

# Create folders inside the "stage" container
resource "azurerm_storage_data_lake_gen2_path" "staging_folders" {
  for_each = {
    for folder in local.staging_folders : folder => {
      container_name = data.azurerm_storage_container.stage.name
      path           = folder
    }
  }

  storage_account_id = data.azurerm_storage_account.adls.id
  filesystem_name    = each.value.container_name
  path               = each.value.path
  resource           = "directory"

  depends_on = [data.azurerm_storage_container.stage]
}
