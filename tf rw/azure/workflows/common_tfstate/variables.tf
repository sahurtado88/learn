variable "subscription_id" {
  default = "7b9202a8-f63c-4c0e-9d2f-bb877f322a25"
  type    = string
}

variable "location" {
  default = "centralus"
  type    = string
}

variable "tfstate_rg_name" {
  default = "rg-0428-tfstate-centralus"
  type    = string
}

variable "tfstate_storage_account_name" {
  default = "ftdsptfstatesa"
  type    = string
}

variable "env_name" {
  type = string
}

variable "env_prefix" {
  type = string
}

variable "tfstate_container_names" {
  default = ["tfstate"]
  type    = list(string)
}

variable "storage_replication_type" {
  default = "GZRS"
  type    = string
}

variable "tags" {
  default = {
    "ApplicationTag"     = "RAIDER Architects POC"
    "ApplicationName"    = "Azure Cloud Services"
    "CostCenter"         = "15567"
    "DataClassification" = "Confidential"
    "Environment"        = "Development"
    "Lifespan"           = "Months"
    "Capability"         = "Network and Cloud Services"
    "ServiceClass"       = "User Managed"
    "ProjectInitiative"  = "FactoryTalk Design Studio"
    "OwnerEmail"         = "noreply@rockwellautomation.com"
    "BusinessUnit"       = "SWC - ENGINEERING SOFTWARE"
  }
  description = "Required tags to deploy Azure resources"
}

variable "az_tenant_id" {
  default = "855b093e-7340-45c7-9f0c-96150415893e"
}
variable "azuredns_client_id" {
  default = ""
}
variable "azuredns_client_secret" {
  default = ""
}

variable "alerts_manage" {}