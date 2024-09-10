variable "global_peering" {
  default = true
}

##### RG for Boot Strap Services  ########
variable "location" {
  default = "eastus2"
  type    = string
}

variable "tags" {
  default = {
    "ApplicationTag"     = "FTDS"
    "ApplicationName"    = "Azure Cloud Services"
    "CostCenter"         = "15567"
    "DataClassification" = "Confidential"
    "Environment"        = "Development"
    "Lifespan"           = "Months"
    "Capability"         = "Network and Cloud Services"
    "ServiceClass"       = "User Managed"
    "ProjectInitiative"  = "FTDS Preview"
    "OwnerEmail"         = "noreply@rockwellautomation.com"
    "BusinessUnit"       = "SWC - ENGINEERING SOFTWARE"
  }
  description = "Required tags to deploy Azure resources"
}

variable "pep_manage" {
  default = true
}

variable "azuredns_client_id" {}
variable "azuredns_client_secret" {}
variable "az_tenant_id" {}

variable "azure_subscription_id_global" {}

# security context

variable "external_access" {
  default = false
}

variable "monitoring_manage_external_access" {
  default = false
}

variable "global_ddos_manage" {
  default = "false"
}

variable "alerts_manage" {}
