variable "env_prefix" {
  type = string
}

variable "env_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
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


variable "service_uri_vault" {
  type = string
}

variable "service_uri_sa" {
  type = string
}

variable "service_uri_network" {
  type = string
}

variable "service_uri_appgw" {
  type = string
}

variable "service_uri_aks" {
  type = string
}

variable "service_uri_db" {
  type = string
}

variable "service_uri_security" {
  type = string
}


variable "sh_location" {
  type    = list(string)
  default = ["East US", "East US 2", "West US", "South Central US", "Central US", "Global"]
}

variable "sh_services" {
  type = list(string)
  default = ["Action Groups",
    "Activity Logs & Alerts",
    "Alerts & Metrics",
    "Alerts",
    "Load Balancer",
    "Virtual Machine Scale Sets",
    "Application Insights",
    "Azure Active Directory",
    "Virtual Machines",
    "Virtual Network",
    "Key Vault",
    "Storage",
    "Azure DNS",
    "Azure Kubernetes Service (AKS)",
    "Azure Cosmos DB",
    "Microsoft Azure portal",
    "Azure Container Registry",
    "Container Registry",
    "Backup",
    "Azure Bastion",
    "Service Bus",
    "Functions",
  "Azure Database for PostgreSQL"]
}

variable "sh_events" {
  type    = list(string)
  default = ["Incident", "Maintenance", "Security"]
}

variable "alerts_manage" {
  type    = bool
  default = false
}

variable "subscription_id" {
  type = string
}


