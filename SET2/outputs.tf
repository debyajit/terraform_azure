output "staging_folder_paths" {
  description = "List of folders created inside the staging container"
  value       = [for folder in local.staging_folders : folder]
}