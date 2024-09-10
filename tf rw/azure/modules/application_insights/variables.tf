variable "application_insights_name" {}
variable "location" {}
variable "rg_name" {}
variable "log_analytics_workspace_id" {}
variable "application_type" {
  default = "web"
}