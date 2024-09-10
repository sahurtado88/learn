variable "firewall_vnet" {}
variable "firewall_subnet_address_prefixes" {
  default = "10.0.1.0/24"
}
variable "firewall_rg" {}
# variable "tags" {}
variable "fw_public_ip_sku" {
  default = "standard"
}
variable "firewall_name" {}
variable "fw_sku_name" {
  default = "AZFW_VNet"
}
variable "fw_sku_tier" {
  default = "Premium"
}
variable "fw_public_ip_allocation_method" {
  default = "Static"
}

variable "firewall_public_ip" {}
variable "fw_ip_configuration" {}


