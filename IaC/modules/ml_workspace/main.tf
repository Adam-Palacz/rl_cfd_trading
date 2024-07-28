data "azurerm_subscription" "current" {}

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

resource "azurerm_log_analytics_workspace" "kv_ml_workspace_la" {
  name                = "kv-ml-workspace-log-analytics"
  location            = azurerm_resource_group.ml_workspace_rg.location
  resource_group_name = azurerm_resource_group.ml_workspace_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 7
}

resource "azurerm_monitor_diagnostic_setting" "key_vault_logs" {
  name                       = "key-vault-logs"
  target_resource_id         = azurerm_key_vault.ml_workspace_kv.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.kv_ml_workspace_la.id

  log {
    category = "AuditEvent"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 7
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 7
    }
  }
}

resource "azurerm_storage_account" "ml_workspace_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.ml_workspace_rg.name
  location                 = azurerm_resource_group.ml_workspace_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  # network_rules {
  #   default_action = "Deny"
  #   ip_rules       = []
  #   virtual_network_subnet_ids = []
  # }
  sas_policy {
    expiration_period = "P30D"
  }
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