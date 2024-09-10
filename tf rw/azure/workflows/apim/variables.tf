variable "location" {}
variable "subscription_id" {}
variable "azure_subscription_id_global" {}
variable "azure_subscription_id_internal" {}
variable "azuredns_client_id" {}
variable "azuredns_client_secret" {}
variable "az_tenant_id" {}
variable "azure_subscription_id_hub_dns" {}

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

variable "env_prefix" {
  default = "ftds"
}
