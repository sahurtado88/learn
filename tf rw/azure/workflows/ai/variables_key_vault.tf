variable "keyvault_sku_name" {
  default = "standard"
}

variable "keyvault_soft_delete_retention_days" {
  default = 7
}

variable "keyvault_purge_protection_enabled" {
  default = true
}

variable "openai_api_key_secret_name" {
  default = "openai-api-key"
}

variable "openai_endpoint_secret_name" {
  default = "openai-endpoint"
}

variable "retrieval_plugin_token_secret_name" {
  default = "retrieval-plugin-bearer-token"
}

variable "azure_search_key_secret_name" {
  default = "azure-search-key"
}

variable "azure_search_endpoint_secret_name" {
  default = "azure-search-endpoint"
}

variable "openai_bearer_token" {
  default   = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
  sensitive = true
}

variable "key_vault_public_network_access_enabled" {
  default = true
}

variable "key_vault_manage_network_acls" {
  default = true
}