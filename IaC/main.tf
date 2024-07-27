module "ml_workspace" {
  source                              = "./modules/ml_workspace"
  resource_group_name                 = var.resource_group_name
  location                            = var.location
  application_insights_name           = var.application_insights_name
  key_vault_name                      = var.key_vault_name
  machine_learning_workspace_name     = var.machine_learning_workspace_name
  key_vault_sku_name                  = var.key_vault_sku_name
  machine_learning_workspace_sku_name = var.machine_learning_workspace_sku_name
}
