variable "subscription_id" {
  description = "Azure subscription ID to use for deployment"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
  default     = "East US"
}

variable "storage_account_name" {
  description = "Name of the ADLS Gen2 storage account"
  type        = string
}

variable "containers" {
  description = "List of containers to create"
  type        = list(string)
  default     = ["stage", "bronze", "silver", "gold"]
}

variable "staging_folders" {
  description = "List of folders to create inside the staging container"
  type        = list(string)
  default     = [
    "ferc/pt/raw/facl",
    "ferc/pt/input/facl",
 
  ]
}
