variable "fw_network_rule_collection" {}
variable "fw_network_rule_collection_rule" {}

variable "fw_network_rule_collection_action" {
  default = "Allow"
}

variable "fw_network_rule_collection_priority" {
  type    = number
  default = 100
}

variable "fw_network_rule_source_addresses" {
  type    = list(string)
  default = ["*"]

}

variable "fw_network_rule_destination_ports" {
  type    = list(string)
  default = ["*"]
}

variable "fw_network_rule_destination_addresses" {
  type    = list(string)
  default = ["*"]
}

variable "fw_network_rule_protocols" {
  type = list(string)
  default = [
    "TCP",
    "UDP",
  ]
}