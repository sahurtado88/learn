variable "az_tenant_id" {}
variable "dns_name_prefix" {}
variable "env_prefix" {
  default = "ftds"
}

variable "gitlab_instance" {}
variable "cmn_namespace_with_spc" {
  type    = list(string)
  default = ["ra-system", "ra-monitoring", "gitlab"]
}
