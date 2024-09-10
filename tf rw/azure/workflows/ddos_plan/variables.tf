variable "location" {
  default = "CentralUS"
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
variable "ddos_protection_name" {
  default = "0413-centralus-ddos-protection-plan"
}
variable "ddos_protection_rg_name" {
  default = "rg-0413-ddos-centralus"
}