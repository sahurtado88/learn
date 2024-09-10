variable "openai_location" {}
variable "cognitive_services_sku_name" {
  default = "S0"
}

variable "cognitive_services_kind" {
  default = "OpenAI"
}

variable "cognitive_public_access_enabled" {
  default = false
}

variable "cognitive_local_auth_enabled" {
  default = true
}

variable "cognitive_dynamic_throttling_enabled" {
  default = false
}

variable "openai_deployment_model_name" {
  default = "gpt-4"
}

variable "openai_deployment_model" {
  default = "gpt-4"
}

variable "openai_deployment_model_version" {
  default = "0125-Preview"
}

variable "openai_scale_type" {
  default = "Standard"
}

variable "openai_tpm" {
  default = 5
}

variable "embeddings_deployment_model_name" {
  default = "text-embedding-ada-002"
}
variable "embeddings_deployment_model" {
  default = "text-embedding-ada-002"
}

variable "embedding_deployment_model_version" {
  default = "2"
}

variable "embedding_scale_type" {
  default = "Standard"
}

variable "embedding_tpm" {
  default = 300
}

variable "openai_completion_deployment_model_name" {
  default = "gpt-35-turbo"
}

variable "openai_completion_deployment_model" {
  default = "gpt-35-turbo"
}

variable "openai_completion_deployment_model_version" {
  default = "0125-Preview"
}

variable "openai_completion_scale_type" {
  default = "Standard"
}

variable "openai_completion_tpm" {
  default = 10
}

variable "openai_global_deployment_model_name" {
  default = "gpt-4o"
}

variable "openai_global_deployment_model" {
  default = "gpt-4o"
}

variable "openai_global_deployment_model_version" {
  default = "2024-05-13"
}

variable "openai_global_scale_type" {
  default = "GlobalStandard"
}

variable "openai_version_upgrade_option" {
  default = "NoAutoUpgrade"
}

variable "openai_global_deployment_tpm" {
  default = 100
}
