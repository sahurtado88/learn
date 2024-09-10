output "keyvault_secret_identity" {
  value = module.aks.keyvault_secret_identity
}

output "key_vault_name" {
  value = local.keyvault_name
}

output "racertpod_identity_id" {
  value = var.key_vault_manage ? module.racertpod_identity[0].id : null
}
output "racertpod_identity_principal_id" {
  value = var.key_vault_manage ? module.racertpod_identity[0].principal_id : null
}
output "racertpod_identity_client_id" {
  value = var.key_vault_manage ? module.racertpod_identity[0].client_id : null
}
output "racertpod_identity_tenant_id" {
  value = var.key_vault_manage ? module.racertpod_identity[0].tenant_id : null
}

# output "gitlab_pg_fqdn" {
#   value = var.gitlab_manage ? module.postgres_gitlab[0].pg_fqdn : null
# }

# output "ftbridge_pod_identity_id" {
#   value = var.manage_ftbridge ? module.ftbridge_identity[0].id : null
# }
