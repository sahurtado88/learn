variable "network_security_group_rg" {}
# variable "tags" {}
variable "nsg_name" {}
variable "nsg_rule" {}
variable "nsg_rule_priority_num" {
  type    = number
  default = 100
}

variable "nsg_rule_direction" {
  default = "Inbound"

}
variable "nsg_rule_access" {
  default = "Allow"
}
variable "nsg_rule_protocol" {
  default = "Tcp"
}
variable "nsg_rule_source_port_range" {
  default = "*"
}
variable "nsg_rule_destination_port_range" {
  default = "*"
}
variable "nsg_rule_source_address_prefix" {
  default = "*"
}
variable "nsg_rule_destination_address_prefix" {
  default = "*"
}
