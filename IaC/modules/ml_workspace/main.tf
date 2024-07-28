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

resource "azurerm_storage_account" "ml_workspace_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.ml_workspace_rg.name
  location                 = azurerm_resource_group.ml_workspace_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_machine_learning_workspace" "ml_workspace" {
  name                    = var.machine_learning_workspace_name
  location                = azurerm_resource_group.ml_workspace_rg.location
  resource_group_name     = azurerm_resource_group.ml_workspace_rg.name
  application_insights_id = azurerm_application_insights.ml_workspace_ai.id
  key_vault_id            = azurerm_key_vault.ml_workspace_kv.id
  sku_name                = var.machine_learning_workspace_sku_name
  storage_account_id      = azurerm_storage_account.ml_workspace_storage.id
  identity {
    type = "SystemAssigned"
  }
}