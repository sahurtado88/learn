variable "fw_app_rule_collection_priority" {
  default = 100
}

variable "fw_app_rule_collection_action" {
  default = "Allow"
}

variable "fw_app_rule_collection_rule_source_addresses" {
  default = [
    "*",
  ]
}

variable "fw_app_rule_collection_rule_target_fqdns" {
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