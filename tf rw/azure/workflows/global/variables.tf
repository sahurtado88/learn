variable "location" {}

variable "subscription_id" {}
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

variable "monitoring_manage_external_access" {
  default = false
}

variable "pep_manage" {
  default = true
}
variable "azure_subscription_id_global" {}

variable "global_pep_manual_conn" {
  default = false
}

variable "boot_subresource_names" {
  default = ["registry"]
}


variable "azure_subscription_id_internal" {}
variable "azuredns_client_id" {}
variable "azuredns_client_secret" {}
variable "az_tenant_id" {}
# security context

variable "global_ddos_manage" {
  default = "false"
}
variable "storage_account_manage_selected_networks" {
  default = true
}
variable "storage_account_manage_pep" {
  default = true
}

variable "alerts_manage" {}
