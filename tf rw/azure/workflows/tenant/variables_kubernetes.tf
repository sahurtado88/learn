# Kubernetes secrets

# For Kubernetes Provider
variable "client_certificate" {
  default = ""
}
variable "client_key" {
  default = ""
}
variable "cluster_ca_certificate" {
  default = ""
}
variable "aks_host" {
  default = ""
}
variable "database_secret_name_dim" {
  default = "dim-database"
}
variable "tenant_manage_cosmosdb" {
  default = false
}
variable "ftra-auth0-token-secret" {
  default = "ftra-auth0-token"
}
variable "tenant_manage_asb" {
  default = false
}
variable "topic_event_secret" {
  default = "topic-event"
}
variable "topic_mgmt_secret" {
  default = "topic-mgmt"
}

variable "ai_secret" {
  default = "tenant-assistant"
}

variable "azure_openai_endpoint_secret_name" {
  default = "azure-openai-endpoint"
}

variable "azure_openai_key_secret_name" {
  default = "azure-openai-key"
}

variable "search_service_endpoint_secret_name" {
  default = "search-service-endpoint"
}

variable "search_service_key_secret_name" {
  default = "search-service-key"
}
