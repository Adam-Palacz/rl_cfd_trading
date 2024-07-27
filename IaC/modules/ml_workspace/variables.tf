variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "application_insights_name" {
  description = "Name of the Application Insights instance"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault instance"
  type        = string
}

variable "machine_learning_workspace_name" {
  description = "Name of the Machine Learning Workspace"
  type        = string
}

variable "key_vault_sku_name" {
  description = "SKU name for the Key Vault instance"
  type        = string
}

variable "machine_learning_workspace_sku_name" {
  description = "SKU name for the Machine Learning Workspace"
  type        = string
}
