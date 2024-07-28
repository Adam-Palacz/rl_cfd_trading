data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "ml_workspace_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_application_insights" "ml_workspace_ai" {
  name                = var.application_insights_name
  location            = azurerm_resource_group.ml_workspace_rg.location
  resource_group_name = azurerm_resource_group.ml_workspace_rg.name
  application_type    = "web"
}

resource "azurerm_key_vault" "ml_workspace_kv" {
  name                = var.key_vault_name
  location            = azurerm_resource_group.ml_workspace_rg.location
  resource_group_name = azurerm_resource_group.ml_workspace_rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku_name
}

resource "azurerm_machine_learning_workspace" "ml_workspace" {
  name                    = var.machine_learning_workspace_name
  location                = azurerm_resource_group.ml_workspace_rg.location
  resource_group_name     = azurerm_resource_group.ml_workspace_rg.name
  application_insights_id = azurerm_application_insights.ml_workspace_ai.id
  key_vault_id            = azurerm_key_vault.ml_workspace_kv.id
  sku_name                = var.machine_learning_workspace_sku_name
}
