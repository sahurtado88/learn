variable "aks_name" {}
variable "aks_rg_name" {}
variable "grafana_secret_name" {}

variable "harness_provider_account_id" {}
variable "harness_provider_api_key" {}

variable "harness_secret_manager_identifier" {
  default = "harnessSecretManager"
}
