variable "env_name" {}
variable "env_prefix" {}
variable "location" {}

# Variables for internal subscription
variable "azure_subscription_id_internal" {}
variable "azuredns_client_id" {
  sensitive = true
}
variable "azuredns_client_secret" {
  sensitive = true
}
variable "az_tenant_id" {
  sensitive = true
}

variable "tags" {
  default = {
    "ApplicationName"    = "RAIDER Cloud Services"
    "ApplicationTag"     = "RAIDER Cloud"
    "BusinessUnit"       = "SWC - ENGINEERING SOFTWARE"
    "Capability"         = "Network and Cloud Services"
    "CostCenter"         = "10272"
    "DataClassification" = "Confidential"
    "Environment"        = "Development"
    "Lifespan"           = "Months"
    "OwnerEmail"         = "noreply@rockwellautomation.com"
    "ProjectInitiative"  = "FactoryTalk Design Studio"
    "ServiceClass"       = "User Managed"
  }
}