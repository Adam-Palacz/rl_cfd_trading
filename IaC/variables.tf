variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-ml-workspace"
}

variable "location" {
  description = "Location of the resources"
  type        = string
  default     = "West Europe"
}

variable "application_insights_name" {
  description = "Name of the Application Insights instance"
  type        = string
  default     = "ai-ml-workspace"
}

variable "key_vault_name" {
  description = "Name of the Key Vault instance"
  type        = string
  default     = "kv-ml-workspace"
}

variable "machine_learning_workspace_name" {
  description = "Name of the Machine Learning Workspace"
  type        = string
  default     = "mlw-workspace"
}

variable "key_vault_sku_name" {
  description = "SKU name for the Key Vault instance"
  type        = string
  default     = "standard"
}

variable "storage_account_name" {
  description = "Name of the Storage Account"
  type        = string
  default     = "saeuwmlworkspace"
}

variable "machine_learning_workspace_sku_name" {
  description = "SKU name for the Machine Learning Workspace"
  type        = string
  default     = "Basic"
}
