variable "env_prefix" {}
variable "env_name" {}
variable "openai_location" {}
variable "ai_manage" {
  default = true
}

variable "search_service_private_dns" {
  default = "privatelink.search.windows.net"
}
variable "cognitive_services_private_dns" {
  default = "privatelink.openai.azure.com"
}

