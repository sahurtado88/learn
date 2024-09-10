output "keyvault_secret_identity" {
  value = module.aks.keyvault_secret_identity
}

output "key_vault_name" {
  value = local.keyvault_name
}
output "gitlab_pg_fqdn" {
  value = var.gitlab_manage ? module.postgres_gitlab[0].pg_fqdn : null
}

