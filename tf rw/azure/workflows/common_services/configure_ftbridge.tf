# module "ftbridge_storage_container" {
#   count          = var.manage_ftbridge ? 1 : 0
#   source         = "../../modules/storage_container"
#   storage_name   = module.cmn_storage_account.storage_name
#   container_name = var.ftbridge_container_name
# }

# module "ftbridge_identity" {
#   count                 = var.manage_ftbridge ? 1 : 0
#   source                = "../../modules/managed_identity"
#   rg_name               = local.rg_general
#   location              = var.location
#   managed_identity_name = var.ftbridge_identity_name
# }

# resource "azurerm_role_assignment" "bridge2cmnstorage" {
#   count                = var.manage_ftbridge ? 1 : 0
#   scope                = module.cmn_storage_account.storage_id # Resource
#   role_definition_name = var.ftbridge_identity_role
#   principal_id         = module.ftbridge_identity[count.index].principal_id # Key
# }