variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the existing ADLS Gen2 storage account"
  type        = string
}