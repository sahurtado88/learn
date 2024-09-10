
variable "firewall_name" {}
variable "firewall_rg" {}
variable "fw_app_rule_collection" {}
variable "fw_app_rule_collection_priority" {
  type    = number
  default = 100
}
variable "fw_app_rule_collection_action" {
  default = "Allow"
}
variable "fw_app_rule_collection_rule" {}
variable "fw_app_rule_collection_rule_source_addresses" {
  type = list(string)
  default = [
    "*",
  ]
}
variable "fw_app_rule_collection_rule_target_fqdns" {
  type = list(string)
  default = [
    "*",
  ]
}
variable "fw_app_rule_collection_rule_protocol_port" {
  default = "443"
}
variable "fw_app_rule_collection_rule_protocol_type" {
  default = "Https"
}