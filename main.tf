provider "azurerm" {
  features {}
  subscription_id = var.subscription_id

}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "adls" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
}


resource "azurerm_storage_container" "containers" {
  for_each              = toset(var.containers)
  name                  = each.value
  storage_account_name  = azurerm_storage_account.adls.name
  container_access_type = "private"
}

resource "azurerm_storage_data_lake_gen2_path" "staging_folders" {
  for_each = {
    for folder in var.staging_folders :
    folder => {
      container_name = "staging"
      path           = folder
    }
  }

  storage_account_id = azurerm_storage_account.adls.id
  filesystem_name    = each.value.container_name
  path               = each.value.path
  resource           = "directory"

  depends_on = [
    azurerm_storage_container.containers["staging"]
  ]
}