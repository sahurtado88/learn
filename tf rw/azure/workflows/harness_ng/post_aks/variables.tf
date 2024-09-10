variable "env_name" {}
variable "env_prefix" {}
variable "cluster_index" {}

##### HARNESS ########

# Platform
variable "harness_provider_account_id" {}
variable "harness_provider_api_key" {}

# Environment
variable "harness_org_id" {}
variable "harness_app" {}
variable "harness_env" {}
variable "harness_env_id" {}
variable "harness_infra_def_name_kub_deploy" {}
variable "harness_infra_def_name_native_helm" {}

# Secrets
variable "harness_secret_manager_identifier" {
  default = "harnessSecretManager"
}
variable "harness_aks_client_certificate_name" {}
variable "harness_aks_host_name" {}
variable "harness_aks_client_key_name" {}
variable "harness_aks_cluster_ca_certificate_name" {}
variable "harness_aks_username" {}
variable "harness_aks_password" {}
variable "harness_aks_k8s_cloud_provider" {}
variable "harness_sa_token_secret_name" {}
variable "harness_sa_ca_cert_secret_name" {}
