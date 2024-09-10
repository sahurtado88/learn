variable "pep_manage" {
  default = true
}
variable "search_service_pe_manual_connection" {
  default = false
}

variable "cognitive_services_pe_manual_connection" {
  default = false
}

variable "search_service_subresource_names" {
  default = ["searchService"]
}

variable "cognitive_services_subresource_names" {
  default = ["account"]
}
