# variable "firewall_subnet" {}
variable "fw_public_ip_sku" {
  default = "Standard"
}
variable "firewall_name" {}

variable "fw_public_ip_allocation_method" {
  default = "Static"
}

variable "firewall_public_ip" {
  default = "Firewall Public IP Name"

}
variable "fw_ip_configuration" {
  default = "Firewall IP configuration"
}

variable "common_manage_firewall" {
  default = false
}
