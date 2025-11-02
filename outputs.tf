output "storage_account_name" {
  value = azurerm_storage_account.adls.name
}

output "container_names" {
  value = [for c in values(azurerm_storage_container.containers) : c.name]
}

output "staging_folder_paths" {
  description = "List of folders created inside the staging container"
  value = [for folder in var.staging_folders : folder]
}