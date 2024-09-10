variable "location" {}
variable "subscription_id_tenant" {}

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